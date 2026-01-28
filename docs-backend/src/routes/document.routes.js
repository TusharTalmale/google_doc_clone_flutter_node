import express from "express";
import {verifyToken} from "../utils/auth.middleware.js";
import { canEdit } from "../utils/permission.middleware.js";
import * as documentController from "../controller/document.controller.js";
import { validateDocumentContent } from "../utils/validation.middleware.js";

const router = express.Router();

router.use(verifyToken); // Protect all routes

// Basic CRUD
router.post("/create", documentController.createDocument);
router.get("/me", documentController.getAllDocuments);
router.get("/:id", documentController.getDocumentById);
router.delete("/:id", documentController.deleteDocument);

// Editing & Saving
router.post("/title/:id", canEdit, documentController.updateTitle);
router.post("/save/:id", canEdit,validateDocumentContent, documentController.saveDocument);
router.get("/trash/all", documentController.getTrash); 
router.post("/trash/restore/:id", documentController.restoreTrash); 
router.post("/title/:id", canEdit, documentController.updateTitle);

// Version Control
router.get("/versions/:id", documentController.getVersions);
router.post("/restore/:id", canEdit, documentController.restoreVersion);

// Collaboration
router.post("/share/:id", canEdit,validateDocumentContent, documentController.shareDocument);
router.post("/remove-collaborator/:id", canEdit, documentController.removeCollaborator);

export default router;
