import Document from "../model/Document.js";

export const autoSave = async (documentId, content, userId) => {
  const doc = await Document.findById(documentId);

  if (!doc) {
    throw new Error("Document not found");
  }

  // Update content and save state
  doc.content = content;
  doc.saveState = {
    status: "saved",
    lastSavedAt: new Date(),
  };
  doc.updatedAt = new Date();
  
  // We do NOT increment version here. 
  // Version snapshots are handled by a separate timer or manual action.
  
  await doc.save();
  return doc;
};