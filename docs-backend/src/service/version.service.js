import DocumentVersion from "../model/DocumentVersion.js";
import * as documentService from "../service/document.service.js";

export const createVersion = async (documentId, content, userId, reason = "manual") => {
  // const doc = await Document.findById(documentId);
  // if (!doc) throw new Error("Document not found");

  // // Update document content and save state
  // doc.content = content;
  // doc.saveState = {
  //   status: "saved",
  //   lastSavedAt: new Date()
  // };
  const doc = await documentService.updateDocumentContent(documentId, content, userId);

  // Increment version
  doc.versioning.currentVersion += 1;
  doc.versioning.lastSnapshotAt = new Date();

  await doc.save();

  // Create snapshot
  const version = await DocumentVersion.create({
    documentId,
    versionNumber: doc.versioning.currentVersion,
    snapshot: content,
    createdBy: userId,
    reason
  });

  return version;
};

export const getDocumentVersions = async (documentId) => {
  return DocumentVersion.find({ documentId })
    .sort({ versionNumber: -1 })
    .populate("createdBy", "name email");
};

export const restoreVersion = async (documentId, versionId, userId) => {
  const version = await DocumentVersion.findById(versionId);
  if (!version) throw new Error("Version not found");

  // Restore creates a NEW version with the old content
  return createVersion(documentId, version.snapshot, userId, "restore");
};