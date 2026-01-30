import mongoose from "mongoose";

const documentActivitySchema = new mongoose.Schema({
  // documentId: {
  //   type: mongoose.Schema.Types.ObjectId,
  //   ref: "Document",
  //   required: true,
  //   index: true
  // },
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true
  },
  action: {
    type: String,
    required: true
    // e.g., "created", "renamed", "shared", "removed_collaborator", "moved_to_trash", "restored"
  },
  metadata: {
    type: mongoose.Schema.Types.Mixed,
    default: {}
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

documentActivitySchema.index({ documentId: 1, createdAt: -1 });

export default mongoose.model("DocumentActivity", documentActivitySchema);