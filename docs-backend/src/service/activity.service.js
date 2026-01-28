import DocumentActivity from "../model/DocumentActivity.js";

export const logActivity = async (documentId, userId, action, metadata = {}) => {
  try {
    await DocumentActivity.create({
      documentId,
      userId,
      action,
      metadata
    });
  } catch (error) {
    console.error("Activity Log Error:", error);
    // We suppress errors here so activity logging doesn't block the main user action
  }
};

export const getActivity = async (documentId) => {
  return DocumentActivity.find({ documentId })
    .sort({ createdAt: -1 })
    .limit(50)
    .populate("userId", "name email profilePic");
};