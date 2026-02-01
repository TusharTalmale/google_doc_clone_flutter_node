import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_doc/models/user_model.dart';
import 'package:google_doc/repositories/auth_repository.dart';  // FIXED: Removed duplicate import
import 'package:google_doc/services/storage_service.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb ? 'YOUR_WEB_CLIENT_ID' : null,
    scopes: ['email', 'profile'],
  );

  @override
  Future<UserModel?> build() async {
    // Try to restore session
    final token = await ref.read(storageServiceProvider).getToken();
    if (token == null) return null;
    
    try {
      final user = await ref.read(authRepositoryProvider).getProfile();
      return user;
    } catch (e) {
      // Token invalid, clear storage
      await ref.read(storageServiceProvider).deleteToken();
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await ref.read(authRepositoryProvider).login(email, password);
      await _saveUser(user);
      return user;
    });
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await ref.read(authRepositoryProvider).register(name, email, password);
      await _saveUser(user);
      return user;
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final account = await _googleSignIn.signIn();
      if (account == null) throw Exception('Sign in cancelled');
      
      final auth = await account.authentication;
      if (auth.idToken == null) throw Exception('Failed to get ID token');
      
      final user = await ref.read(authRepositoryProvider).googleLogin(auth.idToken!);
      await _saveUser(user);
      return user;
    });
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    await ref.read(storageServiceProvider).clearAll();
    state = const AsyncData(null);
  }

  Future<void> _saveUser(UserModel user) async {
    if (user.token != null) {
      await ref.read(storageServiceProvider).saveToken(user.token!);
    }
    await ref.read(storageServiceProvider).saveUser(jsonEncode(user.toJson()));
  }
}