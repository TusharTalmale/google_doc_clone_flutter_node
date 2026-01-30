import * as Y from 'yjs';
import { MongodbPersistence } from 'y-mongodb-provider';

// In-memory storage for active documents
const docs = new Map(); // { documentId: Y.Doc }

// MongoDB persistence (stores document updates)
const persistence = new MongodbPersistence(process.env.DB_URI, {
  collectionName: 'yjs-docs',
  flushSize: 100,
  multipleCollections: false
});

const updateBuffer = new Map(); // docId -> [updates]
const saveTimeouts = new Map(); // docId -> timeout

export const getYDoc = async (documentId) => {
  if (docs.has(documentId)) {
    return docs.get(documentId);
  }

  // Create new Yjs document
  const ydoc = new Y.Doc();
  
  // Load from MongoDB if exists
const persistedUpdates = await persistence.getUpdates(documentId);
if (persistedUpdates && persistedUpdates.length > 0) {
  persistedUpdates.forEach(update => {
    Y.applyUpdate(ydoc, update);
  });
} 

if (persistedUpdates) {
    Y.applyUpdate(ydoc, persistedUpdates);
  }

  // Setup persistence on every update
  ydoc.on('update', async (update) => {
    if (!updateBuffer.has(documentId)) {
      updateBuffer.set(documentId, []);
    }
    updateBuffer.get(documentId).push(update);

    if (!saveTimeouts.has(documentId)) {
      saveTimeouts.set(documentId, setTimeout(async () => {
        saveTimeouts.delete(documentId);
        const updates = updateBuffer.get(documentId);
        updateBuffer.delete(documentId);
        if (updates && updates.length > 0) {
          await persistence.storeUpdate(documentId, Y.mergeUpdates(updates));
        }
      }, 30000)); // Flush every 30 seconds
    }
  });

  // Cleanup after 30 minutes of inactivity
  const cleanup = setTimeout(() => {
    docs.delete(documentId);
    ydoc.destroy();
  }, 30 * 60 * 1000);

  ydoc.on('destroy', () => {
    clearTimeout(cleanup);
  });

  docs.set(documentId, ydoc);
  return ydoc;
};

export const deleteYDoc = (documentId) => {
  if (docs.has(documentId)) {
    docs.get(documentId).destroy();
    docs.delete(documentId);
  }
};

export { persistence };