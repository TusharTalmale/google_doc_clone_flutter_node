import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/utils/route_constants.dart';
import '../../provider/auth_controller.dart';
import '../../widgets/auth_widgets.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
        error: (_, __) => _form(context, ref),
        data: (_) => _form(context, ref),
      ),
    );
  }

  Widget _form(BuildContext context, WidgetRef ref) {
    return AuthCard(
      children: [
        const AuthHeader(
          title: "Create Account",
          subtitle: "Start your journey with us",
        ),
        const SizedBox(height: 24),
        AuthTextField(controller: _nameController, label: "Name"),
        const SizedBox(height: 16),
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
        AuthPrimaryButton(
          text: "Register",
          onPressed: () {
            ref
                .read(authControllerProvider.notifier)
                .register(
                  _nameController.text.trim(),
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
          },
        ),
        const SizedBox(height: 16),
        const AuthDivider(),
        const SizedBox(height: 16),
        GoogleAuthButton(
          text: "Sign up with Google",
          onPressed: () =>
              ref.read(authControllerProvider.notifier).signInWithGoogle(),
        ),
        const SizedBox(height: 16),
        AuthFooter(
          text: "Already have an account? Login",
          onPressed: () => context.pushReplacementNamed(AppRoutes.login),
        ),
      ],
    );
  }
}
