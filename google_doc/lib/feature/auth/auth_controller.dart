import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_doc/services/storage_service.dart';
import 'auth_repository.dart';
import '../../models/user_model.dart';

final authControllerProvider =
    AsyncNotifierProvider<AuthController, UserModel?>(AuthController.new);

class AuthController extends AsyncNotifier<UserModel?> {
  late final AuthRepository _repo;
  late final StorageService _storage;
  // Use the singleton instance
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<UserModel?> build() async {
    _repo = ref.read(authRepositoryProvider);
    _storage = ref.read(storageServiceProvider);

    // 1. Initialize GoogleSignIn
    // serverClientId is the WEB OAuth Client ID (used by Google to identify the app)
    await _googleSignIn.initialize(
      serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
    );

    // 2. Listen to authentication events (Required for Web & Mobile consistency)
    _googleSignIn.authenticationEvents.listen((event) async {
      if (event is GoogleSignInAuthenticationEventSignIn) {
        await _handleGoogleUser(event.user);
      }
    });

    // 3. Attempt silent sign-in (Lightweight)
    // This checks if the user is already signed in from a previous session
    await _googleSignIn.attemptLightweightAuthentication();

    return _loadUserFromStorage();
  }

  Future<UserModel?> _loadUserFromStorage() async {
    final token = await _storage.getToken();
    if (token != null) {
      try {
        // Validate token by fetching profile
        final user = await _repo.getUserProfile();
        return user.copyWith(token: token);
      } catch (e) {
        // Token might be invalid/expired
        await _storage.deleteToken();
        return null;
      }
    }
    return null;
  }

  // 🔐 LOGIN
  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await _repo.login(email, password);
      if (user.token != null) await _storage.saveToken(user.token!);
      return user;
    });
  }

  // 📝 REGISTER
  Future<void> register(String name, String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await _repo.register(name, email, password);
      if (user.token != null) await _storage.saveToken(user.token!);
      return user;
    });
  }

  // 🔵 GOOGLE SIGN IN
  Future<void> signInWithGoogle() async {
    if (await _googleSignIn.supportsAuthenticate()) {
      try {
        await _googleSignIn.authenticate();
        // The stream listener in build() will handle the result
      } catch (e) {
        // Handle cancellation or errors (optional, as stream might also catch some)
      }
    }
  }

  Future<void> _handleGoogleUser(GoogleSignInAccount account) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final auth = await account.authentication;
      final idToken = auth.idToken;
      if (idToken == null) {
        throw Exception('Google ID token missing');
      }
      final user = await _repo.googleLogin(idToken);
      if (user.token != null) await _storage.saveToken(user.token!);
      return user;
    });
  }

  Future<void> logout() async {
    await _storage.deleteToken();
    state = const AsyncData(null);
  }
}
