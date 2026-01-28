// utils/permission.util.js
export const hasEditAccess = (doc, userId) => {
  const uid = userId.toString(); // Ensure string comparison
  return (
    doc.ownerId.toString() === uid ||
    doc.collaborators.some(
      (c) =>
        c.userId.toString() === uid && ["owner", "editor"].includes(c.role)
    )
  );
};

export const hasViewAccess = (doc, userId) => {
  const uid = userId.toString();
  return (
    doc.ownerId.toString() === uid ||
    doc.collaborators.some((c) => c.userId.toString() === uid)
  );
};