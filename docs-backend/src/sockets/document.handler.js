import { getYDoc } from '../../yjs.store.js';
import * as Y from 'yjs';
import * as presenceStore from '../presence.store.js';
import * as activityService from '../../service/activity.service.js';
import Document from '../../model/Document.js';
import { hasEditAccess } from '../../utils/permission.util.js';

export const handleDocumentJoin = (socket, io) => async (documentId) => {
  try {
    const user = socket.user;
    
    // Check permissions
    const doc = await Document.findById(documentId);
    if (!doc) return socket.emit('error', { message: 'Document not found' });
    
    // Join room
    socket.join(documentId);
    
    // Get or create Yjs document
    const ydoc = await getYDoc(documentId);
    
    // Send current state to user
    const stateVector = Y.encodeStateAsUpdate(ydoc);
    socket.emit('document-state', Buffer.from(stateVector).toString('base64'));
    
    // Setup awareness (presence)
    const currentUsers = presenceStore.addPresence(documentId, socket.id, user);
    io.to(documentId).emit('presence-update', currentUsers);
    
    // Log activity
    await activityService.logActivity(documentId, user._id, 'opened');
    
    console.log(`User ${user.name} joined doc ${documentId}`);
  } catch (error) {
    console.error('Join document error:', error);
    socket.emit('error', { message: 'Failed to join document' });
  }
};

export const handleAwarenessUpdate = (socket, io) => async ({ documentId, awareness }) => {
  // Broadcast cursor/selection changes to others
  const users = presenceStore.updateAwareness(documentId, socket.id, awareness);
  socket.to(documentId).emit('presence-update', users);
};

export const handleYjsUpdate = (socket, io) => async ({ documentId, update }) => {
  try {
    const user = socket.user;
    
    // Verify edit permissions
    const doc = await Document.findById(documentId);
    if (!doc || !hasEditAccess(doc, user._id.toString())) {
      return socket.emit('error', { message: 'Not authorized' });
    }

    // Apply to Yjs document
    const ydoc = await getYDoc(documentId);
    const binUpdate = Buffer.from(update, 'base64');
    
    try {
      Y.applyUpdate(ydoc, binUpdate);
    } catch (err) {
      return socket.emit('error', { message: 'Invalid update format' });
    }
    
    // Broadcast to others (not sender)
    socket.to(documentId).emit('yjs-update', update);
    
    // Throttle MongoDB save (save every 5 seconds max)
    throttleSave(documentId, ydoc, user._id);
    
  } catch (error) {
    console.error('Yjs update error:', error);
  }
};

// Throttle map
const saveThrottle = new Map();

const throttleSave = (documentId, ydoc, userId) => {
  if (saveThrottle.has(documentId)) return;
  
  saveThrottle.set(documentId, true);
  setTimeout(async () => {
    try {
      const content = ydoc.getText('quill').toDelta();
      await Document.findByIdAndUpdate(documentId, {
        content: content,
        'saveState.status': 'saved',
        'saveState.lastSavedAt': new Date(),
        $inc: { 'stats.totalEdits': 1, revision: 1 },
        'stats.lastEditor': userId
      });
      console.log(`Document ${documentId} saved to MongoDB`);
    } catch (err) {
      console.error('Save error:', err);
    } finally {
      saveThrottle.delete(documentId);
    }
  }, 5000); // Save every 5 seconds max
};