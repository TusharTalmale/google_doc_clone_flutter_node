import "dotenv/config";
import express from "express";
import cors from "cors";
import { createServer } from "http";
import { initializeSocket, getIO } from "./src/sockets/socket.js";
import connectDB from "./src/utils/db.js";

import authRouter from "./src/routes/auth.route.js";
import documentRouter from "./src/routes/document.routes.js";
import versionRouter from "./src/routes/version.route.js";
import commentRouter from "./src/routes/comment.routes.js";

const app = express();
const httpServer = createServer(app);

// DB
connectDB();

// MIDDLEWARE (THIS IS ENOUGH ✅)
app.use(cors({
  origin: true,
  methods: ["GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"],
}));
app.use(express.json());

// ROUTES
app.use("/api/auth", authRouter);
app.use("/api/documents", documentRouter); 
app.use("/api/versions", versionRouter);
app.use("/api/documents", commentRouter);

// SOCKET
initializeSocket(httpServer);

// HEALTH
app.get("/", (_, res) => res.send("🚀 API is running"));

app.get("/health", (_, res) => {
  res.json({ status: "UP" });
});

app.get("/health/full", (_, res) => {
  const io = getIO();
  res.json({
    api: "UP",
    socketClients: io ? io.engine.clientsCount : 0,
  });
});

// START
const PORT = process.env.PORT || 3001;
httpServer.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
