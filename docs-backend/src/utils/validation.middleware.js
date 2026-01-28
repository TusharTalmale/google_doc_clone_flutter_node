// src/middleware/validation.middleware.js

export const validateDocumentContent = (req, res, next) => {
  const { content } = req.body;

  // Quill Deltas must be an Array. 
  // If content is undefined, we assume no changes, which might be valid depending on your logic.
  // But if provided, it MUST be an array.
  if (content && !Array.isArray(content)) {
    return res.status(400).json({ 
      message: "Invalid content format. Content must be a Delta array." 
    });
  }

  next();
};

export const validateShareRequest = (req, res, next) => {
  const { email, role } = req.body;

  // 1. Check Email format
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!email || !emailRegex.test(email)) {
    return res.status(400).json({ message: "Invalid email address" });
  }

  // 2. Check Role
  const validRoles = ["viewer", "editor"];
  if (!role || !validRoles.includes(role)) {
    return res.status(400).json({ 
      message: "Invalid role. Allowed roles: 'viewer', 'editor'" 
    });
  }

  next();
};