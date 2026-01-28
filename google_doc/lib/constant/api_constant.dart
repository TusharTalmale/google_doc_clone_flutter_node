import 'package:flutter/foundation.dart';

class ApiConstants {
  // Use localhost for Web, 10.0.2.2 for Android Emulator
  // If using a physical device, you must use your computer's LAN IP (e.g., 192.168.x.x)
  static const String baseUrl = kIsWeb
      ? 'http://localhost:3001'
      : 'http://10.0.2.2:3001';
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String google = '/api/auth/google';
  static const String profile = '/api/auth/profile';
}
