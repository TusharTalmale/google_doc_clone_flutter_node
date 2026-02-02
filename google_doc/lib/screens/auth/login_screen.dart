import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:google_doc/utils/route_constants.dart';
import '../../widgets/auth_widgets.dart';
import 'package:google_doc/provider/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() => _isLoading = true);
    ref
        .read(authControllerProvider.notifier)
        .login(_emailController.text.trim(), _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, next) {
      next.whenOrNull(
        data: (_) => setState(() => _isLoading = false),
        error: (e, _) {
          setState(() => _isLoading = false);
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
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (_, _) => _buildForm(context),
        data: (_) => _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return AuthCard(
      children: [
        const AuthHeader(
          title: "Welcome Back",
          subtitle: "Sign in to continue to your documents",
        ),
        const SizedBox(height: AppSizes.spaceLg),
        AuthTextField(
          controller: _emailController,
          label: "Email",
          hint: "Enter your email",
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: AppSizes.spaceMd),
        AuthTextField(
          controller: _passwordController,
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
          onPressed: _login,
          isLoading: _isLoading,
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
