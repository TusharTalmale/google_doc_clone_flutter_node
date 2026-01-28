const presence = {}; // { documentId: { socketId: { userId, name, color, cursor } } }

export const addPresence = (documentId, socketId, user) => {
  if (!presence[documentId]) {
    presence[documentId] = {};
  }

  presence[documentId][socketId] = {
    userId: user._id,
    name: user.name,
    color: user.color || "#" + Math.floor(Math.random() * 16777215).toString(16), // Fallback random color
    cursor: null,
  };

  return Object.values(presence[documentId]);
};


export const removePresence = (documentId, socketId) => {
  if (!presence[documentId]) return [];

  delete presence[documentId][socketId];

  // Cleanup empty documents to prevent memory leaks
  if (Object.keys(presence[documentId]).length === 0) {
    delete presence[documentId];
    return [];
  }

  return Object.values(presence[documentId]);
};

export const updateCursor = (documentId, socketId, cursor) => {
  if (!presence[documentId] || !presence[documentId][socketId]) return;

  presence[documentId][socketId].cursor = cursor;
  return Object.values(presence[documentId]);
};

export const getPresence = (documentId) => {
  return presence[documentId] ? Object.values(presence[documentId]) : [];
};