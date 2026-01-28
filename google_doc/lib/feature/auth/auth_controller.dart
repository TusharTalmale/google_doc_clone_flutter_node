import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/services/storage_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_repository.dart';
import '../../models/user_model.dart';

final authControllerProvider =
    AsyncNotifierProvider<AuthController, UserModel?>(AuthController.new);

class AuthController extends AsyncNotifier<UserModel?> {
  late final AuthRepository _repo;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? '272866144375-avm3n0kpui1ldft0uluef0bfj7h0a2ro.apps.googleusercontent.com'
        : null,
    scopes: ['email', 'profile'],
  );
  var _storage;
  bool _isAuthenticating = false;

  @override
  Future<UserModel?> build() async {
    _repo = ref.read(authRepositoryProvider);
    _storage = ref.read(storageServiceProvider);
  }

  // 🔵 GOOGLE SIGN IN
  Future<void> signInWithGoogle() async {
    if (_isAuthenticating) return;
    _isAuthenticating = true;

    state = const AsyncLoading();

    try {
      // In 6.2.1 on Web, you can use either .signIn() or .authenticate()
      // .authenticate() is better for modern FedCM/GIS compliance
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        await _handleGoogleUser(googleUser);
      } else {
        // state = AsyncData(await _loadUserFromStorage());
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      _isAuthenticating = false;
    }
  }

  Future<void> _handleGoogleUser(GoogleSignInAccount account) async {
    try {
      final auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken == null) throw Exception('Google ID token missing');

      final user = await _repo.googleLogin(idToken);
      if (user.token != null) await _storage.saveToken(user.token!);

      state = AsyncData(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _storage.deleteToken();
    state = const AsyncData(null);
  }

  // 🔐 LOGIN
  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return _repo.login(email, password);
    });
  }

  // 📝 REGISTER
  Future<void> register(String name, String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return _repo.register(name, email, password);
    });
  }
}
