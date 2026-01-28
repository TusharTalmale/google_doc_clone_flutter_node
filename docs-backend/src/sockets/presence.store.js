const presence = {}; // { documentId: { socketId: { userId, name, color, cursor, typing } } }

export const addPresence = (docId, socketId, user) => {
  if (!presence[docId]) presence[docId] = {};

  presence[docId][socketId] = {
    userId: user._id,
    name: user.name,
    color: "#" + Math.floor(Math.random() * 16777215).toString(16),
    cursor: null,
    typing: false
  };

  return Object.values(presence[docId]);
};

export const removePresence = (docId, socketId) => {
  if (!presence[docId]) return [];
  delete presence[docId][socketId];
  
  if (Object.keys(presence[docId]).length === 0) {
    delete presence[docId];
    return [];
  }
  return Object.values(presence[docId]);
};

export const updateCursor = (docId, socketId, cursor) => {
  if (!presence[docId]?.[socketId]) return [];
  presence[docId][socketId].cursor = cursor;
  return Object.values(presence[docId]);
};

export const setTyping = (docId, socketId, typing) => {
  if (!presence[docId]?.[socketId]) return [];
  presence[docId][socketId].typing = typing;
  return Object.values(presence[docId]);
};