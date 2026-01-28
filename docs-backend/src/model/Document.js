import mongoose from "mongoose";

const collaboratorSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true
  },

  role: {
    type: String,
    enum: ["owner", "editor", "viewer"],
    default: "editor"
  },

  color: {
    type: String,
    default: "#2196f3"
  },

  joinedAt: {
    type: Date,
    default: Date.now
  },

  lastActive: {
    type: Date,
    default: Date.now
  }
}, { _id: false });


// ===============================
// MAIN DOCUMENT SCHEMA
// ===============================

const documentSchema = new mongoose.Schema({

  // -------------------
  // Basic
  // -------------------
  title: {
    type: String,
    required: true,
    trim: true,
    maxlength: 120
  },

  ownerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    index: true,
    required: true
  },

  // -------------------
  // Quill Delta
  // -------------------
  content: {
    type: Array,
    default: [],
    validate: {
      validator: Array.isArray,
      message: "Content must be delta array"
    }
  },

  // -------------------
  // Page layout
  // -------------------
  page: {
    size: {
      type: String,
      enum: ["A4", "Letter", "Legal"],
      default: "A4"
    },

    orientation: {
      type: String,
      enum: ["portrait", "landscape"],
      default: "portrait"
    },

    margin: {
      top: { type: Number, default: 40 },
      bottom: { type: Number, default: 40 },
      left: { type: Number, default: 40 },
      right: { type: Number, default: 40 }
    },

    backgroundColor: {
      type: String,
      default: "#FFFFFF"
    }
  },

  // -------------------
  // Collaboration
  // -------------------
  collaborators: {
    type: [collaboratorSchema],
    default: []
  },

  // -------------------
  // Save system
  // -------------------
  saveState: {
    status: {
      type: String,
      enum: ["saved", "saving", "unsaved"],
      default: "saved"
    },
    lastSavedAt: Date
  },

  // -------------------
  // Version metadata
  // -------------------
  versioning: {
    currentVersion: {
      type: Number,
      default: 1
    },
    lastSnapshotAt: Date
  },

  // -------------------
  // Soft delete (Trash)
  // -------------------
  isDeleted: {
    type: Boolean,
    default: false,
    index: true
  },

  deletedAt: Date

}, {
  timestamps: true
});


// ===============================
// Indexes
// ===============================

documentSchema.index({ ownerId: 1, updatedAt: -1 });
documentSchema.index({ "collaborators.userId": 1 });

export default mongoose.model("Document", documentSchema);
