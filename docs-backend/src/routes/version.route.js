import express from "express";

const router = express.Router();

// GET /api/versions/:documentId
router.get("/:documentId", (req, res) => {
  // TODO: Implement logic to fetch document version history
  res.status(501).json({ message: "Not implemented yet" });
});

// POST /api/versions/restore/:versionId
router.post("/restore/:versionId", (req, res) => {
  // TODO: Implement logic to restore a specific version
  res.status(501).json({ message: "Not implemented yet" });
});

export default router;
