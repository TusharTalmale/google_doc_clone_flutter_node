# 📝 Google Docs Clone

A **full-stack, real-time collaborative document editor** featuring a Flutter cross-platform frontend and a Node.js/Socket.IO backend. This application replicates core Google Docs functionality including rich text editing, real-time multi-user collaboration, document sharing, and offline support.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.8+-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Node.js-18+-339933?style=for-the-badge&logo=node.js&logoColor=white" alt="Node.js"/>
  <img src="https://img.shields.io/badge/MongoDB-Atlas-47A248?style=for-the-badge&logo=mongodb&logoColor=white" alt="MongoDB"/>
  <img src="https://img.shields.io/badge/Socket.IO-Realtime-010101?style=for-the-badge&logo=socket.io&logoColor=white" alt="Socket.IO"/>
</p>

---

## 📋 Table of Contents

- [Features](#-features)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Quick Start](#-quick-start)
- [Frontend (Flutter)](#-frontend-flutter)
- [Backend (Node.js)](#-backend-nodejs)
- [API Reference](#-api-reference)
- [WebSocket Events](#-websocket-events)
- [Screenshots](#-screenshots)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

### 📄 Document Management
| Feature | Description |
|---------|-------------|
| **CRUD Operations** | Create, read, update, and delete documents |
| **Grid/List Views** | Toggle between viewing modes |
| **Search & Filter** | Find documents quickly |
| **Trash & Restore** | Soft delete with recovery option |
| **Favorites** | Star important documents |

### ✏️ Rich Text Editor
| Feature | Description |
|---------|-------------|
| **WYSIWYG Editing** | Powered by Flutter Quill |
| **Text Formatting** | Bold, italic, underline, strikethrough |
| **Block Elements** | Headings, lists, quotes, code blocks |
| **Styling** | Font size, colors, backgrounds |
| **Media** | Image embedding support |
| **History** | Undo/Redo functionality |

### 👥 Real-time Collaboration
| Feature | Description |
|---------|-------------|
| **Live Sync** | Instant document updates across users |
| **Cursor Tracking** | See where collaborators are editing |
| **Presence Indicators** | Know who's currently viewing |
| **Typing Indicators** | Real-time typing status |
| **Conflict Resolution** | Yjs-based CRDT for seamless merging |

### 🔐 Security & Auth
| Feature | Description |
|---------|-------------|
| **Multi-Auth** | Email/password + Google OAuth |
| **JWT Tokens** | Secure session management |
| **Role-Based Access** | Owner, Editor, Viewer permissions |
| **Encrypted Storage** | Secure token storage on device |

### 📶 Offline Support
| Feature | Description |
|---------|-------------|
| **Local Caching** | Documents available offline (Hive) |
| **Edit Queue** | Changes saved locally when offline |
| **Auto-Sync** | Seamless sync when back online |
| **Network Detection** | Real-time connectivity status |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        CLIENT (Flutter)                          │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────────────────┐ │
│  │ Screens │──│Providers│──│  Repos  │──│ Services (Dio/WS)   │ │
│  └─────────┘  └─────────┘  └─────────┘  └──────────┬──────────┘ │
└────────────────────────────────────────────────────│────────────┘
                                                     │
                         HTTP REST + WebSocket       │
                                                     ▼
┌─────────────────────────────────────────────────────────────────┐
│                       SERVER (Node.js)                           │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────┐   ┌─────────────┐   ┌─────────────────────────┐│
│  │ Controllers │───│  Services   │───│ Models (Mongoose)       ││
│  └──────┬──────┘   └──────┬──────┘   └─────────────────────────┘│
│         │                 │                                      │
│         │    ┌────────────▼────────────┐                        │
│         └────│    Event Emitter Bus    │                        │
│              └────────────┬────────────┘                        │
│                           ▼                                      │
│              ┌─────────────────────────┐                        │
│              │   Socket.IO Server      │ ◄── Real-time Events   │
│              └─────────────────────────┘                        │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │   MongoDB Atlas       │
                    └───────────────────────┘
```

---

## 🛠️ Tech Stack

### Frontend (Flutter)
| Category | Technology |
|----------|------------|
| Framework | Flutter 3.8+ / Dart 3.8+ |
| State Management | Riverpod 3.0 |
| Routing | GoRouter |
| HTTP Client | Dio |
| Real-time | Socket.IO Client |
| Rich Text Editor | Flutter Quill |
| Local Storage | Hive, Flutter Secure Storage |
| Auth | Google Sign-In |
| Serialization | Freezed, JSON Serializable |

### Backend (Node.js)
| Category | Technology |
|----------|------------|
| Runtime | Node.js 18+ |
| Framework | Express.js |
| Real-time | Socket.IO |
| Database | MongoDB (Mongoose) |
| CRDT | Yjs |
| Auth | JWT, bcrypt |
| Validation | Express Validator |

---

## 📁 Project Structure

```
google_doc_clone/
│
├── 📱 google_doc/                    # Flutter Frontend
│   ├── lib/
│   │   ├── main.dart                 # App entry point
│   │   ├── models/                   # Data models (Freezed)
│   │   │   ├── user_model.dart
│   │   │   ├── document_model.dart
│   │   │   └── presence_model.dart
│   │   ├── provider/                 # Riverpod controllers
│   │   │   ├── auth_controller.dart
│   │   │   ├── document_controller.dart
│   │   │   └── collaboration_controller.dart
│   │   ├── repositories/             # Data layer
│   │   │   ├── auth_repository.dart
│   │   │   ├── document_repository.dart
│   │   │   └── socket_repository.dart
│   │   ├── screens/                  # UI screens
│   │   │   ├── home/
│   │   │   ├── editor/
│   │   │   └── auth/
│   │   ├── services/                 # Core services
│   │   │   ├── dio_client.dart
│   │   │   ├── socket_client.dart
│   │   │   └── storage_service.dart
│   │   ├── utils/                    # Utilities
│   │   │   ├── app_router.dart
│   │   │   └── app_theme.dart
│   │   └── widgets/                  # Reusable widgets
│   ├── pubspec.yaml
│   └── README.md
│
├── 🖥️ docs-backend/                  # Node.js Backend
│   ├── src/
│   │   ├── controller/               # Route handlers
│   │   │   ├── auth.controller.js
│   │   │   └── document.controller.js
│   │   ├── service/                  # Business logic
│   │   │   ├── auth.service.js
│   │   │   └── document.service.js
│   │   ├── model/                    # Mongoose schemas
│   │   │   ├── User.js
│   │   │   ├── Document.js
│   │   │   └── Version.js
│   │   ├── sockets/                  # WebSocket handlers
│   │   │   ├── socket.js
│   │   │   ├── document.handler.js
│   │   │   └── presence.store.js
│   │   ├── routes/                   # Express routes
│   │   ├── middleware/               # Auth, validation
│   │   └── utils/                    # Helpers
│   ├── index.js                      # Server entry
│   ├── package.json
│   └── .env.example
│
└── README.md                         # This file
```

---

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK** >= 3.8.0  
- **Node.js** >= 18.0.0  
- **MongoDB** (Local or Atlas)  
- **Git**

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/TusharTalmale/google_doc_clone_flutter_node.git
cd google_doc_clone_flutter_node
```

### 2️⃣ Start the Backend

```bash
# Navigate to backend
cd docs-backend

# Install dependencies
npm install

# Create environment file
cp .env.example .env
# Edit .env with your MongoDB URI and secrets

# Start development server
npm run dev
```

### 3️⃣ Start the Frontend

```bash
# Navigate to frontend (new terminal)
cd google_doc

# Install dependencies
flutter pub get

# Generate code (Freezed, Riverpod)
dart run build_runner build --delete-conflicting-outputs

# Run on Chrome
flutter run -d chrome --dart-define=BASE_URL=http://localhost:3001

# OR run on Android (use 10.0.2.2 for emulator)
flutter run -d android --dart-define=BASE_URL=http://10.0.2.2:3001
```

---

## 📱 Frontend (Flutter)

### Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| 🌐 Web | ✅ Ready | Chrome, Edge, Firefox |
| 🤖 Android | ✅ Ready | Android 5.0+ |
| 🍎 iOS | ✅ Ready | iOS 12.0+ |
| 🖥️ macOS | 🔄 Beta | macOS 10.14+ |
| 🪟 Windows | 🔄 Beta | Windows 10+ |
| 🐧 Linux | 🔄 Beta | Ubuntu 18.04+ |

### Key Commands

```bash
# Install dependencies
flutter pub get

# Generate Freezed/Riverpod code
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate)
dart run build_runner watch --delete-conflicting-outputs

# Run tests
flutter test

# Analyze code
flutter analyze

# Build release APK
flutter build apk --release --dart-define=BASE_URL=https://your-api.com

# Build web
flutter build web --dart-define=BASE_URL=https://your-api.com
```

### Configuration

Set the backend URL via `--dart-define`:

```bash
flutter run --dart-define=BASE_URL=http://localhost:3001
```

---

## 🖥️ Backend (Node.js)

### Environment Variables

Create a `.env` file in the `docs-backend` directory:

```env
# Server
PORT=3001
NODE_ENV=development

# Database
DB_URI=mongodb+srv://<username>:<password>@cluster.mongodb.net/google_docs

# Authentication
JWT_SECRET=your_super_secret_jwt_key_here
JWT_EXPIRES_IN=7d

# Google OAuth
GOOGLE_CLIENT_ID=your_google_cloud_client_id

# Optional
CORS_ORIGIN=*
```

### Key Commands

```bash
# Install dependencies
npm install

# Development (with hot reload)
npm run dev

# Production
npm start

# Health check
curl http://localhost:3001/health
```

---

## 📡 API Reference

### Authentication `/api/auth`

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/register` | ❌ | Register new user |
| `POST` | `/login` | ❌ | Login with email/password |
| `POST` | `/google` | ❌ | Google OAuth login |
| `GET` | `/profile` | ✅ | Get current user |

### Documents `/api/documents`

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/create` | Create new document |
| `GET` | `/me` | List user's documents |
| `GET` | `/:id` | Get document by ID |
| `POST` | `/title/:id` | Rename document |
| `POST` | `/save/:id` | Save document content |
| `POST` | `/share/:id` | Add collaborator |
| `DELETE` | `/:id` | Move to trash |

### Trash `/api/documents/trash`

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/all` | List trashed documents |
| `POST` | `/restore/:id` | Restore from trash |

### Versions `/api/versions`

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/:documentId` | Get version history |
| `POST` | `/restore/:versionId` | Restore to version |

---

## 🔌 WebSocket Events

### Client → Server

| Event | Payload | Description |
|-------|---------|-------------|
| `join-document` | `"documentId"` | Join document room |
| `yjs-update` | `{ documentId, update }` | Send Yjs CRDT update |
| `cursor-move` | `{ documentId, cursor }` | Update cursor position |
| `typing-start` | `"documentId"` | Start typing indicator |
| `typing-stop` | `"documentId"` | Stop typing indicator |
| `save-document` | `{ documentId, content }` | Trigger autosave |
| `force-save` | `{ documentId, content }` | Manual save + version |

### Server → Client

| Event | Payload | Description |
|-------|---------|-------------|
| `document-state` | `base64State` | Initial Yjs state |
| `yjs-update` | `base64Update` | Yjs update from others |
| `presence-update` | `[{userId, name, color}]` | Active users list |
| `save-status` | `{ status, lastSavedAt }` | Save confirmation |
| `version-created` | `null` | New version available |
| `error` | `{ message }` | Error notification |

---

## 🔐 Security

- **JWT Authentication** for all protected endpoints
- **WebSocket Auth** via handshake token validation
- **Role-Based Access Control** (Owner/Editor/Viewer)
- **Input Validation** using Express Validator
- **Secure Storage** for tokens (Flutter Secure Storage)
- **HTTPS Ready** for production deployment

---

## 📸 Screenshots

<table>
  <tr>
    <td align="center"><b>🏠 Home Screen</b></td>
    <td align="center"><b>✏️ Document Editor</b></td>
  </tr>
  <tr>
    <td><img src="screenshots/home.png" width="400" alt="Home Screen"/></td>
    <td><img src="screenshots/editor.png" width="400" alt="Editor"/></td>
  </tr>
  <tr>
    <td align="center"><b>🔗 Share Dialog</b></td>
    <td align="center"><b>📱 Mobile View</b></td>
  </tr>
  <tr>
    <td><img src="screenshots/share.png" width="400" alt="Share Dialog"/></td>
    <td><img src="screenshots/mobile.png" width="200" alt="Mobile View"/></td>
  </tr>
</table>

> 📝 **Note:** Add screenshots to a `screenshots/` folder in the project root.

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Code Style

- **Flutter:** Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- **Node.js:** Use ESLint with Prettier
- **Commits:** Use [Conventional Commits](https://www.conventionalcommits.org/)

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [Flutter Quill](https://pub.dev/packages/flutter_quill) - Rich text editor
- [Riverpod](https://riverpod.dev/) - State management
- [Socket.IO](https://socket.io/) - Real-time engine
- [Yjs](https://yjs.dev/) - CRDT implementation
- [MongoDB](https://www.mongodb.com/) - Database
- [Google Docs](https://docs.google.com/) - Inspiration

---

<p align="center">
  <b>Designed & Developed by Tushar Talmale</b>
  <br><br>
  Made with ❤️ using Flutter & Node.js
</p>