import mongoose from "mongoose";

const collaboratorSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true
  },
  role: {
    type: String,
    enum: ["owner", "editor", "viewer", "commenter"], // Added "commenter"
    default: "editor"
  },
  color: {
    type: String,
    default: null // Will be generated dynamically
  },
  joinedAt: {
    type: Date,
    default: Date.now
  },
  lastActive: {
    type: Date,
    default: Date.now
  },
  // Track what they're currently editing (for "User editing Section 3" feature)
  currentSection: {
    type: Number,
    default: null
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

  revision: {
    type: Number,
    default: 0
  },

  // Link sharing
  isPublic: {
    type: Boolean,
    default: false
  },
  
  publicAccess: {
    type: String,
    enum: ["view", "comment", "edit"],
    default: "view"
  },
  
  shareableLink: {
    type: String,
    unique: true,
    sparse: true,
    index: true
  },

  // Settings
  settings: {
    suggestionMode: { type: Boolean, default: false },
    defaultFont: { type: String, default: "Arial" },
    lineSpacing: { type: Number, default: 1.15 }
  },

  // Favorite/Starred
  isFavorite: [{
    userId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    addedAt: { type: Date, default: Date.now }
  }],

  // Thumbnail for list view (base64 of first page or S3 URL)
  thumbnail: {
    type: String,
    default: ""
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
  // Analytics
  // -------------------
  stats: {
    totalEdits: { type: Number, default: 0 },
    wordCount: { type: Number, default: 0 },
    lastEditor: { type: mongoose.Schema.Types.ObjectId, ref: "User" }
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
