import * as Y from 'yjs';
import { MongodbPersistence } from 'y-mongodb-provider';

const docs = new Map(); // { documentId: { ydoc: Y.Doc, cleanup: Timeout } }
const promises = new Map(); // { documentId: Promise<Y.Doc> }

// MongoDB persistence (stores document updates)
const persistence = new MongodbPersistence(process.env.DB_URI, {
  collectionName: 'yjs-docs',
  flushSize: 100,
  multipleCollections: false
});

const updateBuffer = new Map(); // docId -> [updates]
const saveTimeouts = new Map(); // docId -> timeout

export const getYDoc = async (documentId) => {
  // 1. Check if already loaded in memory
  if (docs.has(documentId)) {
    const entry = docs.get(documentId);
    resetCleanup(documentId, entry);
    return entry.ydoc;
  }

  // 2. Check if already loading
  if (promises.has(documentId)) {
    return promises.get(documentId);
  }

  // 3. Load from MongoDB
  const loadPromise = (async () => {
    try {
      const ydoc = await persistence.getYDoc(documentId);
      setupPersistenceAndCleanup(documentId, ydoc);
      promises.delete(documentId);
      return ydoc;
    } catch (error) {
      promises.delete(documentId);
      throw error;
    }
  })();

  promises.set(documentId, loadPromise);
  return loadPromise;
};

const setupPersistenceAndCleanup = (documentId, ydoc) => {
  // Setup persistence on every update
  ydoc.on('update', async (update) => {
    // Reset cleanup whenever there's activity
    if (docs.has(documentId)) {
      resetCleanup(documentId, docs.get(documentId));
    }

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
          try {
            await persistence.storeUpdate(documentId, Y.mergeUpdates(updates));
          } catch (err) {
            console.error(`Failed to store update for ${documentId}:`, err);
          }
        }
      }, 30000)); 
    }
  });

  const entry = {
    ydoc,
    cleanup: null
  };
  docs.set(documentId, entry);
  resetCleanup(documentId, entry);
};

const resetCleanup = (documentId, entry) => {
  if (entry.cleanup) {
    clearTimeout(entry.cleanup);
  }
  
  entry.cleanup = setTimeout(() => {
    console.log(`Cleaning up inactive document: ${documentId}`);
    docs.delete(documentId);
    entry.ydoc.destroy();
  }, 30 * 60 * 1000); // 30 minutes of inactivity
};

export const deleteYDoc = (documentId) => {
  if (docs.has(documentId)) {
    const entry = docs.get(documentId);
    clearTimeout(entry.cleanup);
    entry.ydoc.destroy();
    docs.delete(documentId);
  }
};

export { persistence };