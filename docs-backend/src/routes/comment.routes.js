import express from "express";
import { verifyToken } from "../utils/auth.middleware.js";
import * as commentController from "../controller/comment.controller.js";

const router = express.Router();

router.use(verifyToken);

// POST /api/documents/:documentId/comments
router.post("/:documentId/comments", commentController.addComment);

// GET /api/documents/:documentId/comments  
router.get("/:documentId/comments", commentController.getComments);

// POST /api/comments/:commentId/replies
router.post("/comments/:commentId/replies", commentController.addReply);

// PATCH /api/comments/:commentId/resolve
router.patch("/comments/:commentId/resolve", commentController.resolveComment);

// DELETE /api/comments/:commentId
router.delete("/comments/:commentId", commentController.deleteComment);

export default router;