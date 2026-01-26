import * as authService from "../service/auth.service.js";

export const register = async (req, res) => {
  const { name, email, password } = req.body;

  if (!name || !email || !password) {
    return res.status(400).json({ message: "Missing fields" });
  }

  try {
    const { token, user } = await authService.registerUser({ name, email, password });
    res.status(201).json({
      token,
      user: { id: user._id, name: user.name, email: user.email },
    });
  } catch (error) {
    if (error.message === "User already exists") {
      return res.status(400).json({ message: error.message });
    }
    console.error("Register Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};

export const login = async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: "Missing fields" });
  }

  try {
    const { token, user } = await authService.loginUser({ email, password });
    res.status(200).json({
      token,
      user: { id: user._id, name: user.name, email: user.email },
    });
  } catch (error) {
    if (error.message === "Invalid credentials") {
      return res.status(401).json({ message: error.message });
    }
    console.error("Login Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};

export const googleAuth = async (req, res) => {
  const { idToken } = req.body;
  if (!idToken) {
    return res.status(400).json({ message: "Missing Google Token" });
  }
  try {
    const { token, user } = await authService.googleLogin(idToken);
    res.status(200).json({ token, user });
  } catch (error) {
    console.error("Google Auth Error:", error);
    res.status(500).json({ message: "Google authentication failed" });
  }
};

export const getUserProfile = async (req, res) => {
  try {
    const user = await authService.getUserById(req.user.id);
    res.status(200).json(user);
  } catch (error) {
    if (error.message === "User not found") {
      return res.status(404).json({ message: error.message });
    }
    console.error("Profile Error:", error);
    res.status(500).json({ message: "Server error" });
  }
};