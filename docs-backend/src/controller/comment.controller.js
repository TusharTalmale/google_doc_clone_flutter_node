import * as commentService from "../service/comment.service.js";
import { socketEmitter } from "../sockets/emitter.js";

const sendResponse = (res, status, data, message = "Success") => {
  res.status(status).json({ success: true, message, data });
};

const handleError = (res, error) => {
  console.error("Comment Error:", error);
  const status = error.message.includes("not found") ? 404 : 
                 error.message.includes("Not authorized") ? 403 : 500;
  res.status(status).json({ success: false, message: error.message });
};

export const addComment = async (req, res) => {
  try {
    const { documentId } = req.params;
    const comment = await commentService.createComment(documentId, req.user.id, req.body);
    
    // Notify other users
    socketEmitter.emit("broadcast", {
      documentId,
      event: "new-comment",
      data: comment
    });
    
    sendResponse(res, 201, comment, "Comment added");
  } catch (error) {
    handleError(res, error);
  }
};

export const getComments = async (req, res) => {
  try {
    const comments = await commentService.getComments(req.params.documentId, req.user.id);
    sendResponse(res, 200, comments);
  } catch (error) {
    handleError(res, error);
  }
};

export const addReply = async (req, res) => {
  try {
    const { commentId } = req.params;
    const { content } = req.body;
    const comment = await commentService.replyToComment(commentId, req.user.id, content);
    sendResponse(res, 200, comment, "Reply added");
  } catch (error) {
    handleError(res, error);
  }
};

export const resolveComment = async (req, res) => {
  try {
    const comment = await commentService.resolveComment(req.params.commentId, req.user.id);
    sendResponse(res, 200, comment, "Comment resolved");
  } catch (error) {
    handleError(res, error);
  }
};

export const deleteComment = async (req, res) => {
  try {
    const result = await commentService.deleteComment(req.params.commentId, req.user.id);
    sendResponse(res, 200, result);
  } catch (error) {
    handleError(res, error);
  }
};