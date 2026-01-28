import mongoose from "mongoose";

const userSchema = new mongoose.Schema(

  {
    // -------------------
    // Identity
    // -------------------
    name: {
      type: String,
      required: true,
      trim: true,
      maxlength: 80
    },

    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
      index: true
    },

    password: {
      type: String,
      select: false // never auto-fetch
    },

    profilePic: {
      type: String,
      default: ""
    },

    // -------------------
    // Authentication
    // -------------------
    provider: {
      type: String,
      enum: ["google", "local"],
      default: "google"
    },

    googleId: {
      type: String
    },

    // -------------------
    // Account state
    // -------------------
    isEmailVerified: {
      type: Boolean,
      default: true
    },

    isBlocked: {
      type: Boolean,
      default: false
    },

    // -------------------
    // Collaboration metadata
    // -------------------
    lastActiveAt: {
      type: Date,
      default: Date.now
    },

    status: {
      type: String,
      enum: ["online", "offline"],
      default: "offline"
    },

    // -------------------
    // User preferences
    // -------------------
    preferences: {
      theme: {
        type: String,
        enum: ["light", "dark"],
        default: "light"
      },

      editor: {
        fontSize: { type: Number, default: 14 },
        fontFamily: { type: String, default: "Inter" }
      }
    },

    // -------------------
    // Soft delete
    // -------------------
    isDeleted: {
      type: Boolean,
      default: false,
      index: true
    },

    deletedAt: Date

  },

  {
    timestamps: true
  }
);

// -------------------
// Indexes
// -------------------
userSchema.index({ email: 1 });
userSchema.index({ isDeleted: 1 });

const User = mongoose.model("User", userSchema);

export default User;
