import * as documentService from "../service/document.service.js";
import * as versionService from "../service/version.service.js";
import Document from "../model/Document.js";
import mongoose from "mongoose";
import { socketEmitter } from "../sockets/emitter.js";
import crypto from "crypto";

// Standard response helper
const sendResponse = (res, status, data, message = "Success") => {
  res.status(status).json({
    success: true,
    message,
    data,
  });
};

// Standard error helper
const handleError = (res, error) => {
  console.error("Controller Error:", error);
  const status = error.message.includes("not found") ? 404 : 
                 error.message.includes("authorized") ? 403 : 500;
  res.status(status).json({
    success: false,
    message: error.message || "Internal Server Error",
  });
};

export const createDocument = async (req, res) => {
  try {
    const doc = await documentService.createDocument(req.user.id);
    sendResponse(res, 201, doc, "Document created successfully");
  } catch (error) {
    handleError(res, error);
  }
};

export const getAllDocuments = async (req, res) => {
  try {
    const docs = await documentService.getAllDocuments(req.user.id);
    sendResponse(res, 200, docs);
  } catch (error) {
    handleError(res, error);
  }
};

export const getDocumentById = async (req, res) => {
  try {
    const doc = await documentService.getDocumentById(req.params.id, req.user.id);
    sendResponse(res, 200, doc);
  } catch (error) {
    handleError(res, error);
  }
};

export const updateTitle = async (req, res) => {
  try {
    const { title } = req.body;
    if (!title) throw new Error("Title is required");
    const doc = await documentService.updateDocumentTitle(req.params.id, req.user.id, title);
    sendResponse(res, 200, doc, "Title updated");
  } catch (error) {
    handleError(res, error);
  }
};

export const saveDocument = async (req, res) => {
  try {
    const { content } = req.body;
    await versionService.createVersion(req.params.id, content, req.user.id);
    sendResponse(res, 200, null, "Document saved successfully");
  } catch (error) {
    handleError(res, error);
  }
};

export const getVersions = async (req, res) => {
  try {
    const versions = await versionService.getDocumentVersions(req.params.id);
    sendResponse(res, 200, versions);
  } catch (error) {
    handleError(res, error);
  }
};

export const restoreVersion = async (req, res) => {
  try {
    const { versionId } = req.body;
    if (!versionId) throw new Error("Version ID is required");
    
    const newVersion = await versionService.restoreVersion(req.params.id, versionId, req.user.id);
    socketEmitter.emit("broadcast", {
        documentId: req.params.id,
        event: "receive-changes",
        data: newVersion.snapshot
    });
    
    sendResponse(res, 200, null, "Version restored successfully");
  } catch (error) {
    handleError(res, error);
  }
};

export const shareDocument = async (req, res) => {
  try {
    const { email, role } = req.body;
    if (!email || !role) throw new Error("Email and role are required");
    const doc = await documentService.share(req.params.id, email, role, req.user.id);
    sendResponse(res, 200, doc, "Document shared");
  } catch (error) {
    handleError(res, error);
  }
};

export const removeCollaborator = async (req, res) => {
  try {
    const { userId } = req.body;
    if (!userId) throw new Error("User ID is required");
    const result = await documentService.removeCollaborator(req.params.id, userId, req.user.id);
    sendResponse(res, 200, null, result);
  } catch (error) {
    handleError(res, error);
  }
};

export const deleteDocument = async (req, res) => {
  try {
    await documentService.moveToTrash(req.params.id, req.user.id);
    sendResponse(res, 200, null, "Moved to trash");
  } catch (error) {
    handleError(res, error);
  }
};
export const generateShareLink = async (req, res) => {
  try {
    const { id } = req.params;
    const { access = "view" } = req.body;
    
    const doc = await Document.findById(id);
    if (!doc) throw new Error("Document not found");
    
    // Only owner can generate links
    if (doc.ownerId.toString() !== req.user.id) {
      throw new Error("Only owner can generate share links");
    }

    // Generate unique token
    const shareToken = crypto.randomBytes(16).toString("hex");
    
    doc.shareableLink = shareToken;
    doc.publicAccess = access;
    doc.isPublic = true;
    await doc.save();
    
    const link = `${process.env.CLIENT_URL}/doc/${id}?token=${shareToken}`;
    sendResponse(res, 200, { link, access }, "Share link generated");
  } catch (error) {
    handleError(res, error);
  }
};
// Toggle favorite
export const toggleFavorite = async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;
    
    const doc = await Document.findByIdAndUpdate(id, [
      {
        $set: {
          isFavorite: {
            $cond: {
              if: { $in: [new mongoose.Types.ObjectId(userId), "$isFavorite.userId"] },
              then: { $filter: { input: "$isFavorite", cond: { $ne: ["$$this.userId", new mongoose.Types.ObjectId(userId)] } } },
              else: { $concatArrays: ["$isFavorite", [{ userId: new mongoose.Types.ObjectId(userId), addedAt: new Date() }]] }
            }
          }
        }
      }
    ], { new: true });

    if (!doc) throw new Error("Document not found");

    const isFav = doc.isFavorite.some(f => f.userId.toString() === userId);
    sendResponse(res, 200, { isFavorite: isFav });
  } catch (error) {
    handleError(res, error);
  }
};

// Get document with public link (no auth required if token valid)
export const getDocumentByShareLink = async (req, res) => {
  try {
    const { id } = req.params;
    const { token } = req.query;
    
    const doc = await Document.findById(id)
      .select("title content page collaborators isPublic publicAccess shareableLink ownerId");
    
    if (!doc) throw new Error("Document not found");
    
    // Check if valid share link
    if (!doc.isPublic || doc.shareableLink !== token) {
      throw new Error("Invalid or expired link");
    }
    
    sendResponse(res, 200, {
      document: doc,
      accessLevel: doc.publicAccess // 'view', 'comment', or 'edit'
    });
  } catch (error) {
    handleError(res, error);
  }
};
export const getTrash = async (req, res) => {
  try {
    const docs = await documentService.getTrashDocuments(req.user.id);
    sendResponse(res, 200, docs);
  } catch (error) {
    handleError(res, error);
  }
};

export const updatePageSettings = async (req, res) => {
  try {
    const { size, orientation, margin, backgroundColor } = req.body;
    const doc = await Document.findById(req.params.id);
    
    if (!doc) throw new Error("Document not found");
    
    const updates = {};
    if (size) updates["page.size"] = size;
    if (orientation) updates["page.orientation"] = orientation;
    if (margin) {
      if (margin.top < 0 || margin.top > 200 || 
          margin.bottom < 0 || margin.bottom > 200 ||
          margin.left < 0 || margin.left > 200 ||
          margin.right < 0 || margin.right > 200) {
         throw new Error("Invalid margin values");
      }
      Object.assign(updates, {
        "page.margin.top": margin.top,
        "page.margin.bottom": margin.bottom,
        "page.margin.left": margin.left,
        "page.margin.right": margin.right
      });
    }
    if (backgroundColor) updates["page.backgroundColor"] = backgroundColor;
    
    Object.assign(doc.page, updates);
    await doc.save();
    
    sendResponse(res, 200, doc.page, "Page settings updated");
  } catch (error) {
    handleError(res, error);
  }
};
export const restoreTrash = async (req, res) => {
  try {
    // We don't use 'canEdit' middleware here because the doc is deleted 
    // and might not be found by standard queries.
    // We handle permission inside the service or a specific check.
    
    await documentService.restoreFromTrash(req.params.id, req.user.id);
    sendResponse(res, 200, null, "Document restored successfully");
  } catch (error) {
    handleError(res, error);
  }   
};