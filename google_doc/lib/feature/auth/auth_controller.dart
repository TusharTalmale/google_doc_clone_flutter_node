import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_repository.dart';
import '../../models/user_model.dart';

final authControllerProvider =
    AsyncNotifierProvider<AuthController, UserModel?>(AuthController.new);

class AuthController extends AsyncNotifier<UserModel?> {
  late final AuthRepository _repo;
  // Use the singleton instance
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<UserModel?> build() async {
    _repo = ref.read(authRepositoryProvider);

    // 1. Initialize GoogleSignIn
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

    return null;
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

  // 🔵 GOOGLE SIGN IN
  Future<void> signInWithGoogle() async {
    // On Web, the renderButton handles the flow automatically.
    // On Mobile, we must trigger the interactive flow.
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
      return _repo.googleLogin(idToken);
    });
  }

  Future<void> logout() async {
    state = const AsyncData(null);
  }
}
