import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import {createServer } from "http";
import { initializeSocket , getIO} from "./src/sockets/socket.js";
import connectDB from "./src/utils/db.js";
import authRouter from "./src/routes/auth.route.js";
import documentRouter from "./src/routes/document.routes.js";
import versionRouter from "./src/routes/version.route.js";

dotenv.config();

const app = express();
const httpServer = createServer(app);

// data connection
connectDB();

// middleware
app.use(cors({
  origin: "*", // WARNING: Replace with your frontend URL in production (e.g., "http://localhost:5173")
  methods: ["GET", "POST", "PUT", "DELETE", "PATCH"],
  credentials: true
}));
app.use(express.json());



// routes

app.use("/api/auth", authRouter);
app.use("/api/documents", documentRouter);
app.use("/api/versions", versionRouter);

initializeSocket(httpServer);


app.get("/", (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
      <head>
        <title>Home</title>
      </head>
      <body>
        <h1>🚀 API is running</h1>
        <p>Welcome to my backend server</p>
      </body>
    </html>
  `);
});

app.get("/health", (req, res) => {
  res.status(200).json({
    status: "UP",
    server: "express",
    uptime: process.uptime(),
    timestamp: new Date(),
  });
});
app.get("/health/full", (req, res) => {
  const io = getIO();

  res.json({
    api: "UP",
    socketClients: io ? io.engine.clientsCount : 0,
    memory: process.memoryUsage(),
    uptime: process.uptime(),
    timestamp: new Date(),
  });
});

const PORT = process.env.PORT || 3001;
httpServer.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});
