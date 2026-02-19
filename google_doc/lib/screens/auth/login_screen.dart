import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:google_doc/utils/route_constants.dart';
import '../../widgets/auth_widgets.dart';
import 'package:google_doc/provider/auth_controller.dart';

class _LoginFormControllers {
  final email = TextEditingController();
  final password = TextEditingController();

  void dispose() {
    email.dispose();
    password.dispose();
  }
}

final _loginFormProvider = Provider.autoDispose<_LoginFormControllers>((ref) {
  final controllers = _LoginFormControllers();
  ref.onDispose(controllers.dispose);
  return controllers;
});

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final controllers = ref.watch(_loginFormProvider);
    final isLoading = auth.isLoading;

    ref.listen(authControllerProvider, (_, next) {
      next.whenOrNull(
        error: (e, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(AppSizes.spaceMd),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
            ),
          );
        },
      );
    });

    return Scaffold(
      body: auth.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _buildForm(context, ref, controllers, isLoading),
        data: (_) => _buildForm(context, ref, controllers, isLoading),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    WidgetRef ref,
    _LoginFormControllers controllers,
    bool isLoading,
  ) {
    return AuthCard(
      children: [
        const AuthHeader(
          title: "Welcome Back",
          subtitle: "Sign in to continue to your documents",
        ),
        const SizedBox(height: AppSizes.spaceLg),
        AuthTextField(
          controller: controllers.email,
          label: "Email",
          hint: "Enter your email",
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: AppSizes.spaceMd),
        AuthTextField(
          controller: controllers.password,
          label: "Password",
          hint: "Enter your password",
          obscure: true,
          prefixIcon: Icons.lock_outlined,
        ),
        const SizedBox(height: AppSizes.spaceXs),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Forgot password
            },
            child: Text(
              'Forgot password?',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceMd),
        AuthPrimaryButton(
          text: "Sign In",
          onPressed: () {
            ref
                .read(authControllerProvider.notifier)
                .login(
                  controllers.email.text.trim(),
                  controllers.password.text.trim(),
                );
          },
          isLoading: isLoading,
        ),
        const SizedBox(height: AppSizes.spaceLg),
        const AuthDivider(),
        const SizedBox(height: AppSizes.spaceLg),
        GoogleAuthButton(
          text: "Continue with Google",
          onPressed: () =>
              ref.read(authControllerProvider.notifier).signInWithGoogle(),
        ),
        const SizedBox(height: AppSizes.spaceLg),
        AuthFooter(
          text: "Don't have an account? Create one",
          onPressed: () => context.pushReplacementNamed(AppRoutes.register),
        ),
      ],
    );
  }
}
