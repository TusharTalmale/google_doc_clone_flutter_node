import Comment from "../model/Comment.js";
import Document from "../model/Document.js";
import User from "../model/User.js";
import { hasViewAccess } from "../utils/permission.util.js";

const escapeHtml = (text) => {
  return text
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
};

export const createComment = async (documentId, userId, { anchor, content, type = "comment", suggestedDelta = null }) => {
  const doc = await Document.findById(documentId);
  if (!doc) throw new Error("Document not found");
  if (!hasViewAccess(doc, userId)) throw new Error("Not authorized");

  const comment = await Comment.create({
    documentId,
    userId,
    anchor,
    content: escapeHtml(content),
    type,
    suggestedDelta
  });

  return comment.populate("userId", "name email profilePic");
};

export const getComments = async (documentId, userId) => {
  const doc = await Document.findById(documentId);
  if (!doc) throw new Error("Document not found");
  if (!hasViewAccess(doc, userId)) throw new Error("Not authorized");

  const comments = await Comment.find({ documentId }).sort({ createdAt: -1 }).lean();

  const userIds = new Set();
  comments.forEach(c => {
    userIds.add(c.userId.toString());
    if (c.resolvedBy) userIds.add(c.resolvedBy.toString());
    c.replies.forEach(r => userIds.add(r.userId.toString()));
  });

  const users = await User.find({ _id: { $in: [...userIds] } }).select("name email profilePic").lean();
  const userMap = new Map(users.map(u => [u._id.toString(), u]));

  return comments.map(c => ({
    ...c,
    userId: userMap.get(c.userId.toString()),
    resolvedBy: c.resolvedBy ? userMap.get(c.resolvedBy.toString()) : undefined,
    replies: c.replies.map(r => ({ ...r, userId: userMap.get(r.userId.toString()) }))
  }));
};

export const replyToComment = async (commentId, userId, content) => {
  const comment = await Comment.findById(commentId);
  if (!comment) throw new Error("Comment not found");

  comment.replies.push({
    userId,
    content: escapeHtml(content),
    createdAt: new Date()
  });

  await comment.save();
  return comment.populate("replies.userId", "name profilePic");
};

export const resolveComment = async (commentId, userId) => {
  const comment = await Comment.findByIdAndUpdate(
    commentId,
    {
      resolved: true,
      resolvedBy: userId,
      resolvedAt: new Date()
    },
    { new: true }
  );
  
  if (!comment) throw new Error("Comment not found");
  return comment;
};

export const deleteComment = async (commentId, userId) => {
  const comment = await Comment.findById(commentId);
  if (!comment) throw new Error("Comment not found");
  const doc = await Document.findById(comment.documentId);
const isOwner = doc.ownerId.toString() === userId.toString();
const isAuthor = comment.userId.toString() === userId.toString();
  // Only author and owner can delete
if (!isOwner && !isAuthor) throw new Error("Not authorized");

  await Comment.findByIdAndDelete(commentId);
  return { message: "Comment deleted" };
};