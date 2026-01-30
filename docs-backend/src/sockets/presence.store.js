const presence = {}; // { documentId: { socketId: { userId, name, color, cursor, typing, selection } } }

export const addPresence = (docId, socketId, user) => {
  if (!presence[docId]) presence[docId] = {};

  presence[docId][socketId] = {
    userId: user._id.toString(),
    name: user.name,
    color: generateUserColor(user._id),
    cursor: null,
    selection: null, // { index, length }
    typing: false,
    lastActive: Date.now()
  };

  return Object.values(presence[docId]);
};

export const removePresence = (docId, socketId) => {
  if (!presence[docId]) return [];
  delete presence[docId][socketId];
  
  if (Object.keys(presence[docId]).length === 0) {
    // Schedule deletion to prevent flapping
    setTimeout(() => {
      if (presence[docId] && Object.keys(presence[docId]).length === 0) {
        delete presence[docId];
      }
    }, 60000);
    return [];
  }
  return Object.values(presence[docId]);
};

export const updateCursor = (docId, socketId, cursor) => {
  if (!presence[docId]?.[socketId]) return [];
  presence[docId][socketId].cursor = cursor;
  presence[docId][socketId].lastActive = Date.now();
  return Object.values(presence[docId]);
};

export const updateSelection = (docId, socketId, range) => {
  if (!presence[docId]?.[socketId]) return [];
  presence[docId][socketId].selection = range;
  presence[docId][socketId].lastActive = Date.now();
  return Object.values(presence[docId]);
};

export const setTyping = (docId, socketId, typing) => {
  if (!presence[docId]?.[socketId]) return [];
  presence[docId][socketId].typing = typing;
  // presence[docId][socketId].lastActive = Date.now();

  return Object.values(presence[docId]);
};

export const getPresence = (docId) => {
  return presence[docId] ? Object.values(presence[docId]) : [];
};

export const updateAwareness = (docId, socketId, awareness) => {
  if (!presence[docId]?.[socketId]) return [];
  // Awareness can contain cursor, name, color, user info
  Object.assign(presence[docId][socketId], awareness);
  return Object.values(presence[docId]);
};

// Generate consistent color based on userId
const generateUserColor = (userId) => {
  const colors = [
    '#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FECA57',
    '#FF9FF3', '#54A0FF', '#48DBFB', '#1ABC9C', '#F368E0'
  ];
  let hash = 0;
  for (let i = 0; i < userId.toString().length; i++) {
    hash = userId.toString().charCodeAt(i) + ((hash << 5) - hash);
  }
  return colors[Math.abs(hash) % colors.length];
};