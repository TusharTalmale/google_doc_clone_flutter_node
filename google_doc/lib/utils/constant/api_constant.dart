class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://10.0.2.2:3001', // Android emulator
  );

  // Auth
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String google = '/api/auth/google';
  static const String profile = '/api/auth/profile';

  // Documents
  static const String createDocument = '/api/documents/create';
  static const String myDocuments = '/api/documents/me';
  static const String getDocument = '/api/documents';
  static const String renameDocument = '/api/documents/title';
  static const String saveDocument = '/api/documents/save';
  static const String shareDocument = '/api/documents/share';
  static const String deleteDocument = '/api/documents';
  
  // Trash
  static const String trashAll = '/api/documents/trash/all';
  static const String restoreFromTrash = '/api/documents/trash/restore';
  
  // Versions
  static const String versions = '/api/versions';
  
  // Comments
  static const String comments = '/api/documents'; // /:id/comments
}

class SocketEvents {
  SocketEvents._();

  // Client -> Server
  static const String joinDocument = "join-document";
  static const String yjsUpdate = "yjs-update";
  static const String awarenessUpdate = "awareness-update";
  static const String cursorMove = "cursor-move";
  static const String selectionChange = "selection-change";
  static const String typingStart = "typing-start";
  static const String typingStop = "typing-stop";
  static const String saveDocument = "save-document";
  static const String forceSave = "force-save";

  // Server -> Client
  static const String documentState = "document-state";
  static const String receiveChanges = "receive-changes";
  static const String presenceUpdate = "presence-update";
  static const String saveStatus = "save-status";
  static const String versionCreated = "version-created";
  static const String newComment = "new-comment";
}