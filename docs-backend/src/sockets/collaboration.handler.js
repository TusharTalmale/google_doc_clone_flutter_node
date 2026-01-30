import * as presenceStore from '../presence.store.js';
import Document from '../model/Document.js';
import { hasEditAccess } from '../../utils/permission.util.js';
// Missing Permission Checks in Socket Handlers
// File: collaboration.handler.js
// handleTypingStart, handleCursorMove, handleSelectionChange don't verify if user has view access to the document.
// Vulnerability: Anyone can listen to typing/cursor events if they guess the documentId.
// Fix: Add document check:
// JavaScript
// Copy
// export const handleCursorMove = (socket, io) => async ({ documentId, cursor }) => {
//   const doc = await Document.findById(documentId);
//   if (!hasViewAccess(doc, socket.user._id)) return; // ADD THIS
//   // ... rest
// };
export const handleTypingStart = (socket, io) => async (documentId) => {
     const doc = await Document.findById(documentId);
  if (!hasViewAccess(doc, socket.user._id)) return; 
  const users = presenceStore.setTyping(documentId, socket.id, true);
  socket.to(documentId).emit('presence-update', users);
};

export const handleTypingStop = (socket, io) => (documentId) => {
  const users = presenceStore.setTyping(documentId, socket.id, false);
  socket.to(documentId).emit('presence-update', users);
};

export const handleCursorMove = (socket, io) =>async ({ documentId, cursor }) =>  {
      const doc = await Document.findById(documentId);
  if (!hasViewAccess(doc, socket.user._id)) return;
  const users = presenceStore.updateCursor(documentId, socket.id, cursor);
  socket.to(documentId).emit('cursor-update', {
    userId: socket.user._id,
    cursor
  });
};

export const handleSelectionChange = (socket, io) => async ({ documentId, range }) => {
     const doc = await Document.findById(documentId);
  if (!hasViewAccess(doc, socket.user._id)) return; 
  // Range: { index: number, length: number } - Quill format
  const users = presenceStore.updateSelection(documentId, socket.id, range);
  socket.volatile.to(documentId).emit('selection-update', {
    userId: socket.user._id,
    name: socket.user.name,
    color: users.find(u => u.userId.toString() === socket.user._id.toString())?.color,
    range
  });
};