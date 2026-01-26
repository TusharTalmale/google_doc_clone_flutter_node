import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../feature/auth/auth_controller.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        },
      );
    });

    return Scaffold(
      body: auth.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (_, __) => _form(context, ref),
        data: (_) => _form(context, ref),
      ),
    );
  }

  Widget _form(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(controller: _nameController),
        TextField(controller: _emailController),
        TextField(
          controller: _passwordController,
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(authControllerProvider.notifier).register(
                  _nameController.text.trim(),
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
          },
          child: const Text("Register"),
        ),
        ElevatedButton(
          onPressed: () {
            ref
                .read(authControllerProvider.notifier)
                .signInWithGoogle();
          },
          child: const Text("Sign up with Google"),
        ),
      ],
    );
  }
}
