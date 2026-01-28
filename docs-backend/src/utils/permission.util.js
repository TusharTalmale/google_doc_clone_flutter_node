export const hasEditAccess = (doc, userId) => {
  return (
    doc.ownerId.toString() === userId ||
    doc.collaborators.some(
      (c) =>
        c.userId.toString() === userId && ["owner", "editor"].includes(c.role)
    )
  );
};

export const hasViewAccess = (doc, userId) => {
  return (
    doc.ownerId.toString() === userId ||
    doc.collaborators.some((c) => c.userId.toString() === userId)
  );
};