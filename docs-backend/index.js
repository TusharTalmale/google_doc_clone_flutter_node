import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import authRouter from "./src/routes/auth.route.js";
import connectDB from "./src/utils/db.js";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3001;

// middleware
app.use(cors());
app.use(express.json());

// connect database
connectDB();

// routes
app.get("/", (req, res) => {
  res.send("API is running...");
});

app.use("/api/auth", authRouter);

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});
