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
  
  // Update analytics
  if (!doc.stats) doc.stats = { totalEdits: 0, wordCount: 0 };
  
  doc.stats.totalEdits += 1;
  doc.stats.lastEditor = userId;
  doc.stats.wordCount = JSON.stringify(content)
    .replace(/<[^>]+>/g, "")
    .split(/\s+/).length;


  // We do NOT increment version here. 
  // Version snapshots are handled by a separate timer or manual action.
  
  await doc.save();
  return doc;
};