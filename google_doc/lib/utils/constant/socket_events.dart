class SocketEvents {
  SocketEvents._();
  // client -> server
  static const String joinDocument = "join-document";
  static const String sendChanges = "send-changes";
  static const String cursorMove = "cursor-move";
  static const String typingStart = "typing-start";
  static const String typingStop = "typing-stop";
  static const String saveDocument = "save-document";
  static const String forceSave = "force-save";
  static const String healthPing = "health-ping";
  // server -> client
  static const String receiveChanges = "receive-changes";
  static const String presenceUpdate = "presence-update";
  static const String saveStatus = "save-status";
  static const String versionCreated = "version-created";
  static const String healthPong = "health-pong";
}
