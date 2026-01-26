// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// final storageServiceProvider = Provider<StorageService>((ref) {
//   return StorageService();
// });

// class StorageService {
//   final _storage = const FlutterSecureStorage();
//   static const _tokenKey = 'auth_token';

//   Future<void> saveToken(String token) async {
//     await _storage.write(key: _tokenKey, value: token);
//   }

//   Future<String?> getToken() async {
//     return await _storage.read(key: _tokenKey);
//   }

//   Future<void> deleteToken() async {
//     await _storage.delete(key: _tokenKey);
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

class StorageService {
  static const _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}

