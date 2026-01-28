import { Server } from "socket.io";
import { socketAuth } from "../middleware/socketAuth.js";
import * as presenceStore from "./presence.store.js";
import * as autosaveService from "../service/autosave.service.js";
import * as documentService from "../service/document.service.js";
import * as versionService from "../service/version.service.js";
import * as activityService from "../service/activity.service.js";
import Document from "../model/Document.js";

let io;
const lastSave = {}; // Throttle map: { documentId: timestamp }

export const initializeSocket = (server) => {
  io = new Server(server, {
    cors: {
      origin: "*", // Configure this for production
      methods: ["GET", "POST"],
    },
  });

  // Middleware
  io.use(socketAuth);

  io.on("connection", (socket) => {
    const user = socket.user;
    
    // 1. Join Document
    socket.on("join-document", (documentId) => {
      socket.join(documentId);
      
      // Add to presence store
      const currentUsers = presenceStore.addPresence(documentId, socket.id, user);
      
      // Broadcast new presence list to everyone in the room
      io.to(documentId).emit("presence-update", currentUsers);
      
      // Log "opened" activity
      activityService.logActivity(documentId, user._id, "opened");
      
      console.log(`User ${user.name} joined doc ${documentId}`);
    });

    // 2. Real-time Typing (Broadcasting Deltas)
    socket.on("send-changes", async ({ documentId, delta }) => {
      // Security: Check permissions
      const allowed = await canEdit(documentId, user._id.toString());
      if (!allowed) return;

      // Broadcast delta to everyone ELSE in the room
      socket.to(documentId).emit("receive-changes", delta);
    });

    // 3. Cursor Tracking
    socket.on("cursor-move", ({ documentId, cursor }) => {
      const currentUsers = presenceStore.updateCursor(documentId, socket.id, cursor);
      // Broadcast cursor updates (throttle this on frontend usually, but we emit here)
      socket.to(documentId).emit("presence-update", currentUsers);
    });

    // 4. Autosave (Triggered by frontend idle timer)
    socket.on("save-document", async ({ documentId, content }) => {
      // Security: Check permissions
      const allowed = await canEdit(documentId, user._id.toString());
      if (!allowed) return;

      // Throttle: Prevent spamming saves (max 1 save per 2 seconds per doc)
      const now = Date.now();
      if (lastSave[documentId] && now - lastSave[documentId] < 2000) return;
      lastSave[documentId] = now;

      try {
        await autosaveService.autoSave(documentId, content, user._id);
        // Notify everyone that the document is saved
        io.to(documentId).emit("save-status", { status: "saved", lastSavedAt: new Date() });
      } catch (error) {
        console.error("Autosave failed:", error);
        socket.emit("save-status", { status: "error", message: "Save failed" });
      }
    });

    // 5. Manual/Force Save (Creates Version)
    socket.on("force-save", async ({ documentId, content }) => {
      // Security: Check permissions
      const allowed = await canEdit(documentId, user._id.toString());
      if (!allowed) return;

      try {
        await versionService.createVersion(documentId, content, user._id);
        io.to(documentId).emit("save-status", { status: "saved", lastSavedAt: new Date() });
        io.to(documentId).emit("version-created"); // Notify to refresh version list
      } catch (error) {
        console.error("Force save failed:", error);
      }
    });

    // 6. Disconnect
    socket.on("disconnecting", () => {
      const rooms = [...socket.rooms];
      rooms.forEach((documentId) => {
        if (documentId !== socket.id) {
          const currentUsers = presenceStore.removePresence(documentId, socket.id);
          io.to(documentId).emit("presence-update", currentUsers);
        }
      });
    });

    socket.on("disconnect", () => {
      // Standard disconnect logic handled in 'disconnecting' to access rooms
      console.log(`User ${user.name} disconnected`);
    });
  });
};

// Helper to broadcast updates from Controllers (e.g., Restore)
export const broadcastToDocument = (documentId, event, data) => {
  if (io) {
    io.to(documentId).emit(event, data);
  }
};

// Helper to check permissions inside socket events
const canEdit = async (documentId, userId) => {
  const doc = await Document.findById(documentId);
  if (!doc) return false;

  const isOwner = doc.ownerId.toString() === userId;
  const isEditor = doc.collaborators.some(
    (c) => c.userId.toString() === userId && (c.role === "owner" || c.role === "editor")
  );

  return isOwner || isEditor;
};