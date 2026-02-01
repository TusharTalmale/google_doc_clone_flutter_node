import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/auth_widgets.dart';
import 'package:google_doc/provider/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(WidgetRef ref) {
    ref
        .read(authControllerProvider.notifier)
        .login(_emailController.text.trim(), _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, next) {
      next.whenOrNull(
        error: (e, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.toString())));
        },
      );
    });

    return Scaffold(
      body: auth.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _buildForm(context, ref),
        data: (_) => _buildForm(context, ref),
      ),
    );
  }

  Widget _buildForm(BuildContext context, WidgetRef ref) {
    return AuthCard(
      children: [
        const AuthHeader(title: "Sign In", subtitle: "Welcome back"),
        const SizedBox(height: 24),
        AuthTextField(
          controller: _emailController,
          label: "Email",
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          controller: _passwordController,
          label: "Password",
          obscure: true,
        ),
        const SizedBox(height: 24),
        AuthPrimaryButton(text: "Sign In", onPressed: () => _login(ref)),
        const SizedBox(height: 16),
        const AuthDivider(),
        const SizedBox(height: 16),
        GoogleAuthButton(
          text: "Sign in with Google",
          onPressed: () =>
              ref.read(authControllerProvider.notifier).signInWithGoogle(),
        ),
        const SizedBox(height: 16),
        AuthFooter(
          text: "Don't have an account? Register",
          onPressed: () => Navigator.pushNamed(context, '/register'),
        ),
      ],
    );
  }
}
