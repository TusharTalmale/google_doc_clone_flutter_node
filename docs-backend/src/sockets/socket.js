import { Server } from "socket.io";
import { socketEmitter } from "./emitter.js";
import * as presenceStore from "./presence.store.js";
import * as documentHandler from "./document.handler.js";
import * as collaborationHandler from "./collaboration.handler.js";
import Document from "../model/Document.js";
import { socketAuth } from "../utils/socketAuth.js";

let io;

export const initializeSocket = (server) => {
  io = new Server(server, {
    cors: {
      origin: "*",  // Or specify your Flutter web URL: "http://localhost:7357"
      methods: ["GET", "POST"],
      credentials: true,
      allowedHeaders: ["Authorization", "Content-Type"]  // <-- ADD THIS
    },
    // Remove transports from here - let client decide
    allowEIO3: true,  // <-- ADD THIS for compatibility
  });
  

  // Middleware
  io.use(socketAuth);
 
  // Handle Emitter events (for HTTP routes to trigger socket events)
  const ALLOWED_EVENTS = ['receive-changes', 'new-comment', 'presence-update', 'document-list-update'];
  socketEmitter.on("broadcast", ({ documentId, event, data }) => {
    if (io && ALLOWED_EVENTS.includes(event)) {
      io.to(documentId).emit(event, data);
    } 
  });

  socketEmitter.on("permission-revoked", ({ documentId, userId }) => {
    if (io) {
      const room = io.sockets.adapter.rooms.get(documentId);
      if (room) {
        for (const socketId of room) {
          const socket = io.sockets.sockets.get(socketId);
          if (socket && socket.user && socket.user._id.toString() === userId) {
            socket.leave(documentId);
            socket.emit("error", { message: "Permission revoked" });
          }
        }
      }
    }
  });

  io.on("connection", (socket) => {
    const userId = socket.user._id.toString();
    socket.join(userId); // Join personal room for list updates
    console.log("Socket connected:", socket.id, "User:", socket.user.name, "Room:", userId);

    // Health check
    socket.on("health-ping", () => {
      socket.emit("health-pong", {
        socketId: socket.id,
        status: "connected",
        time: new Date(),
      });
    });

    // Document Operations
    socket.on("join-document", documentHandler.handleDocumentJoin(socket, io));
    socket.on("yjs-update", documentHandler.handleYjsUpdate(socket, io));
    socket.on("awareness-update", documentHandler.handleAwarenessUpdate(socket, io));

    // Collaboration Features
    socket.on("typing-start", collaborationHandler.handleTypingStart(socket, io));
    socket.on("typing-stop", collaborationHandler.handleTypingStop(socket, io));
    socket.on("cursor-move", collaborationHandler.handleCursorMove(socket, io));
    socket.on("selection-change", collaborationHandler.handleSelectionChange(socket, io));

    // Legacy support (remove after migrating to Yjs)
    socket.on("send-changes", async ({ documentId, delta }) => {
      const doc = await Document.findById(documentId);
      if (!doc) return;
      socket.to(documentId).emit("receive-changes", { documentId, delta });
    });

    // Disconnect
    socket.on("disconnecting", () => {
      const rooms = [...socket.rooms];
      rooms.forEach((documentId) => {
        if (documentId !== socket.id) {
          const currentUsers = presenceStore.removePresence(documentId, socket.id);
          io.to(documentId).emit("presence-update", currentUsers);
        }
      });
    });

    socket.on("disconnect", (reason) => {
      console.log(`❌ ${socket.id} disconnected: ${reason}`);
    });
  });
};

export const getIO = () => io;