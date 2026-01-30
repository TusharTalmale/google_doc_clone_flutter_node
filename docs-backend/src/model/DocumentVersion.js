import mongoose from "mongoose";

const documentVersionSchema = new mongoose.Schema({

  documentId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Document",
    required: true,
    index: true
  },

  versionNumber: {
    type: Number,
    required: true
  },

  snapshot: {
    type: Array,
    required: true
  },

  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },

  reason: {
    type: String,
    enum: ["auto", "manual", "restore"],
    default: "auto"
  },

  savedAt: {
    type: Date,
    default: Date.now
  }

}, {
  timestamps: false
});

documentVersionSchema.index({ documentId: 1, versionNumber: -1 });

export default mongoose.model("DocumentVersion", documentVersionSchema);
