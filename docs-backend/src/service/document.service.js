import Document from "../model/Document.js";
import User from "../model/User.js";
import * as activityService from "./activity.service.js";
import { hasEditAccess, hasViewAccess } from "../utils/permission.util.js";
const { deleteYDoc } = require('../yjs.store.js');

// create doc 
export const createDocument = async (userId) => { 
    const document = await Document.create({
    title : "Untitled Document",
    content : [],
    ownerId : userId,
    collaborators : [{
        userId : userId,
        role : "owner"
    }]
    });
    await activityService.logActivity(document._id, userId, "created");
    return document;
}

// get all docs
export const getAllDocuments = async (userId) => {
    return Document.find({
        isDeleted   : false,
        $or : [
            {ownerId : userId},
            {"collaborators.userId" : userId}
        ]
    
}).sort({createdAt : -1})
.select('title ownerId updatedAt collaborators stats isFavorite page');
};

// get single doc
export const getDocumentById = async (documentId, userId) => {
    const document = await Document.findById(documentId);
    
    if (!document || document.isDeleted) {
        throw new Error("Document not found or deleted");
    }
    
    if (!hasViewAccess(document, userId)) throw new Error("Not authorized");

    return document;
} 
// update doc
export const updateDocumentTitle = async (documentId, userId, title) => {
  const doc = await Document.findById(documentId);
  if (!doc) throw new Error("Document not found");
  
  if (!hasEditAccess(doc, userId)) throw new Error("You are not authorized to update this document");

  doc.title = title;
  doc.updatedAt = Date.now();
  await doc.save();
  
  await activityService.logActivity(doc._id, userId, "renamed", {
    title
  });
  
  return doc;
}

export const updateDocumentContent = async (documentId, content, userId) => {
  const doc = await Document.findById(documentId);
  if (!doc) throw new Error("Document not found");

  doc.content = content;
  doc.saveState = {
    status: "saved",
    lastSavedAt: new Date(),
  };
  doc.updatedAt = new Date();

  // Update basic analytics
  if (!doc.stats) doc.stats = { totalEdits: 0, wordCount: 0 };
  doc.stats.totalEdits += 1;
  doc.stats.lastEditor = userId;
  
  // Basic word count logic
  const text = Array.isArray(content) ? content.map(op => typeof op.insert === 'string' ? op.insert : "").join("") : "";
  doc.stats.wordCount = text.trim().split(/\s+/).filter(w => w.length > 0).length;

  return await doc.save();
};


// UPDATE PAGE SETTINGS 
export const updatePageSettings = async (documentId, userId, pageSettings) => { 
    const doc = await Document.findById(documentId);
    if (!doc) throw new Error("Document not found");
    
    if (!hasEditAccess(doc, userId)) throw new Error("You are not authorized to update this document");
    
    doc.page = {
        ...doc.page,
        ...pageSettings
    };
    doc.updatedAt = Date.now();
    await doc.save();
    return doc
}

// SHARE DOCUMENT
export const share = async (documentId, email, role, actorId) => {
  const user = await User.findOne({ email });
  if (!user) throw new Error("User not found");

  const doc = await Document.findById(documentId);

  const exists = doc.collaborators.find(
    c => c.userId.toString() === user._id.toString()
  );

  if (!exists) {
    doc.collaborators.push({
      userId: user._id,
      role
    });
    await doc.save();
    await activityService.logActivity(documentId, actorId, "shared", { email, role });
  }
  return doc;
};

// ADD COLLABORATOR
export const addCollaborator = async (documentId, email, role) => {
    // Reusing share logic as it does the same thing
    return share(documentId, email, role);
}

// REMOVE COLLABORATOR

export const removeCollaborator = async (documentId, userId, actorId) => {
  const doc = await Document.findById(documentId);
  if (!doc) throw new Error("Document not found");

  doc.collaborators = doc.collaborators.filter(
    c => c.userId.toString() !== userId
  );
  await doc.save();
  await activityService.logActivity(documentId, actorId, "removed_collaborator", { removedUserId: userId });
  return "Collaborator removed successfully";
};

// TRASH
export const moveToTrash = async (id, userId) => {
  await Document.findByIdAndUpdate(id, {
    isDeleted: true,
    deletedAt: new Date()
  });
  await activityService.logActivity(id, userId, "moved_to_trash");
  await deleteYDoc(id); 
};

export const restoreFromTrash = async (id, userId) => {
  await Document.findByIdAndUpdate(id, {
    isDeleted: false,
    deletedAt: null
  });
  await activityService.logActivity(id, userId, "restored");
};

export const getTrashDocuments = async (userId) => {
  return Document.find({
    isDeleted: true,
    $or: [
      { ownerId: userId },
      { "collaborators.userId": userId } // Collaborators should also see docs they had access to
    ]
  })
  .sort({ deletedAt: -1 }) // Show most recently deleted first
  .select("title updatedAt deletedAt ownerId"); // Optimize: don't fetch heavy content
};
// DELETE DOCUMENT