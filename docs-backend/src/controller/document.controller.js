import * as documentService from "../service/document.service.js";
import * as versionService from "../service/version.service.js";
import { broadcastToDocument } from "../sockets/socket.js";

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
    
    // Broadcast the restored content to all connected sockets
    broadcastToDocument(req.params.id, "receive-changes", newVersion.snapshot);
    
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