import mongoose from "mongoose";

const replySchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true
  },
  content: {
    type: String,
    required: true,
    maxlength: 1000
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

const commentSchema = new mongoose.Schema({
  documentId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Document",
    required: true,
    index: true
  },
  
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true
  },
  
  // Position in Quill document
 anchor: {
  yjsRelativePosition: Object, // Use Y.createRelativePositionFromAbsoluteIndex
  absoluteIndex: Number // Fallback
},
  
  content: {
    type: String,
    required: true,
    maxlength: 2000
  },
  
  resolved: {
    type: Boolean,
    default: false
  },
  
  resolvedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },
  
  resolvedAt: {
    type: Date
  },
  
  // Threaded replies
  replies: [replySchema],
  
  // For suggestions/track changes
  type: {
    type: String,
    enum: ["comment", "suggestion"],
    default: "comment"
  },
  
  // If it's a suggestion, store the proposed changes
  suggestedDelta: {
    type: mongoose.Schema.Types.Mixed,
    default: null
  }

}, {
  timestamps: true
});

commentSchema.index({ documentId: 1, createdAt: -1 });
commentSchema.index({ documentId: 1, resolved: 1 });

export default mongoose.model("Comment", commentSchema);