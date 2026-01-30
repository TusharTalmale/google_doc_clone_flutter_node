import 'package:flutter/foundation.dart';

class ApiConstants {
  // Use localhost for Web, 10.0.2.2 for Android Emulator
  // If using a physical device, you must use your computer's LAN IP (e.g., 192.168.x.x)
  static const String baseUrl = kIsWeb
      ? 'http://localhost:3001'
      : 'http://10.0.2.2:3001';
  // auth routes
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String google = '/api/auth/google';
  static const String profile = '/api/auth/profile';
  // document routes
  static const String createDocument = "/documents/create";
  static const String myDocuments = "/documents/me";
  static const String getDocument = "/documents"; // /:id
  static const String renameDocument = "/documents/title"; // /:id
  static const String shareDocument = "/documents/share"; // /:id
  static const String deleteDocument = "/documents"; // /:id
  // trash
  static const String trashAll = "/documents/trash/all";
  static const String restoreFromTrash = "/documents/trash/restore"; // /:id
  // version
  static const String versions = "/versions"; // /:documentId
  static const String restoreVersion = "/versions/restore"; // /:versionId
}
