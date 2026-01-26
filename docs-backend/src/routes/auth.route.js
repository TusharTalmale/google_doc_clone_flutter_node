import express from "express";
import { register, login, googleAuth, getUserProfile } from "../controller/auth.controller.js";
import { validatePassword, verifyToken } from "../utils/auth.middleware.js";

const authRouter = express.Router();

authRouter.post("/register", validatePassword, register);
authRouter.post("/login", login);
authRouter.post("/google", googleAuth);
authRouter.get("/profile", verifyToken, getUserProfile);

export default authRouter;