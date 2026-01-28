# 📄 Google Docs Clone Backend

High-performance, real-time collaborative editing engine built with **Node.js, Express, Socket.IO, and MongoDB**.

![Node](https://img.shields.io/badge/Node.js-18%2B-green?style=flat-square)
![Socket.IO](https://img.shields.io/badge/Socket.IO-Realtime-black?style=flat-square)
![MongoDB](https://img.shields.io/badge/MongoDB-Atlas-4EA94B?style=flat-square)
![Arch](https://img.shields.io/badge/Architecture-Event%20Driven-orange?style=flat-square)

---

## 🏗️ System Architecture

This backend utilizes a **Layered Architecture** decoupled by a robust **Event Bus** to handle high-concurrency real-time edits.

### The 3-Layer Pattern

*   **Controller Layer:** Handles HTTP requests (`/api`), validation, and response formatting. Zero business logic.
*   **Service Layer:** Contains core logic (e.g., Autosave throttling, Permission checks, Trash management).
*   **Data Access Layer:** Mongoose models (`Document`, `User`, `Version`) for MongoDB interactions.

### Event-Driven Decoupling

To prevent circular dependencies between the HTTP API and the WebSocket server, we use a Singleton Event Emitter.

```text
HTTP Request ➝ Controller ➝ Service ➝ Database Update
                                 ↓
                            Event Emitter
                                 ↓
                          Socket.IO Server ➝ Broadcast to Client
```

---

## 📡 REST API Reference

### 1. Authentication & User `/api/auth`

| Method | Endpoint | Auth | Description |
| :--- | :--- | :--- | :--- |
| `POST` | `/register` | ❌ | Register a new user account. |
| `POST` | `/login` | ❌ | Login with email/password. Returns JWT. |
| `POST` | `/google` | ❌ | Authenticate via Google OAuth token. |
| `GET` | `/profile` | ✅ | Get current user details. |

### 2. Documents `/api/documents`

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/create` | Create a blank "Untitled" document. |
| `GET` | `/me` | List all documents owned by/shared with user. |
| `GET` | `/:id` | Get document content (Delta) & metadata. |
| `POST` | `/title/:id` | Rename a document. |
| `POST` | `/share/:id` | Add collaborator (Viewer/Editor) via email. |
| `DELETE` | `/:id` | Soft delete document (Move to trash). |

### 3. Trash Management `/api/documents/trash`

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/all` | Get list of deleted documents. |
| `POST` | `/restore/:id` | Recover a deleted document. |

### 4. Version History `/api/versions`

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/:documentId` | Get list of historical snapshots. |
| `POST` | `/restore/:versionId` | Revert document to this specific version. |

---

## 🔌 WebSocket API

All events are emitted to `/` namespace. Handshake requires `token` in auth object.

### ➡️ Client Emits (Requests)

| Event Name | Payload | What it does |
| :--- | :--- | :--- |
| `join-document` | `"doc_id_string"` | Join room. Triggers "opened" activity log. |
| `send-changes` | `{ documentId, delta }` | Sends Quill Delta (typing update). |
| `cursor-move` | `{ documentId, cursor: {index, length, name} }` | Updates user cursor position. |
| `typing-start` | `"doc_id_string"` | Sets typing status to TRUE. |
| `save-document` | `{ documentId, content }` | Trigger Autosave Trigger Autosave (Server-side throttle: 1 save per document every 2 seconds).. |
| `force-save` | `{ documentId, content }` | Manual Save. Creates a new Version snapshot. |
| `health-ping` | `null` | Check connection health. |

### ⬅️ Server Emits (Responses)

| Event Name | Payload | What client should do |
| :--- | :--- | :--- |
| `receive-changes` | `delta_object` | Apply delta to Quill editor instance. |
| `presence-update` | `[ {userId, name, color, cursor} ]` | Update active users list and cursor overlays. |
| `save-status` | `{ status: "saved", lastSavedAt }` | Update "Saved..." indicator in UI header. |
| `version-created` | `null` | Refetch version history list if open. |
| `health-pong` | `{ socketId, status, time }` | Confirms active socket connection. |
| `typing-stop` | `"doc_id_string"` | Sets typing indicator to FALSE. |

---

## 🩺 Health & Monitoring

Use these endpoints to monitor uptime and system status.

*   `GET /health`: Lightweight check (Returns 200 OK + uptime).
*   `GET /health/full`: Detailed stats (Socket clients count, Memory usage).
*   **WebSocket:** Emit `health-ping` to receive `health-pong`.
| `health-pong` | `{ socketId, status, time }` | Confirms active socket connection. |


## 🔒 Security

- JWT required for all protected REST endpoints.
- WebSocket handshake validates JWT before connection.
- Document access enforced at:
  - HTTP layer
  - Socket event layer
- Editors and viewers have separate permission rules.
- Autosave and version creation blocked for read-only users.

## ⚙️ Setup & Installation

### 1. Environment Variables (.env)

```env
PORT=3001
DB_URI=mongodb+srv://&lt;username&gt;:&lt;password&gt;@cluster.mongodb.net/docs
JWT_SECRET=your_super_secret_jwt_key
GOOGLE_CLIENT_ID=your_google_cloud_client_id
```

### 2. Run Local

```bash
# Install dependencies
npm install

# Run in dev mode (nodemon)
npm run dev

# Run in production
npm start
```

---

**Designed & Developed by Tushar Talmale**