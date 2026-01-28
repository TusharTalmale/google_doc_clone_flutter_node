import Document from "../model/Document.js";
import { hasEditAccess } from "../utils/permission.util.js"; // Import the utility

export const canEdit = async (req, res, next) => {
  try {
    const { id } = req.params; 
    const userId = req.user.id; 

    const doc = await Document.findById(id);

    if (!doc) {
        return res.status(404).json({ message: "Document not found" });
    }

    // Use the utility function instead of manual logic
    if (!hasEditAccess(doc, userId)) {
      return res.status(403).json({ message: "Not authorized to edit this document" });
    }

    req.doc = doc; // Still attach doc to avoid refetching in the controller
    next();
  } catch (error) {
    console.error("Permission Middleware Error:", error);
    res.status(500).json({ message: "Server error checking permissions" });
  }
};