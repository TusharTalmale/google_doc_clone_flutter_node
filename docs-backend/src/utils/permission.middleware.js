import Document from "../model/Document.js";

export const canEdit = async (req, res, next) => {
  try {
    const { id } = req.params; // Document ID from URL
    const userId = req.user.id; // Assuming auth middleware sets req.user

    const doc = await Document.findById(id);

    if (!doc) return res.status(404).json({ message: "Document not found" });

    const isOwner = doc.ownerId.toString() === userId;
    const isCollaborator = doc.collaborators.some(
      (c) => c.userId.toString() === userId && (c.role === "owner" || c.role === "editor")
    );

    if (!isOwner && !isCollaborator) {
      return res.status(403).json({ message: "Not authorized to edit this document" });
    }

    req.doc = doc; // Attach doc to request to avoid refetching
    next();
  } catch (error) {
    res.status(500).json({ message: "Server error checking permissions" });
  }
};