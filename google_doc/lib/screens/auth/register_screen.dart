import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:google_doc/utils/route_constants.dart';
import '../../provider/auth_controller.dart';
import '../../widgets/auth_widgets.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    setState(() => _isLoading = true);
    ref.read(authControllerProvider.notifier).register(
          _nameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => _form(context),
        data: (_) => _form(context),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return AuthCard(
      children: [
        const AuthHeader(
          title: "Create Account",
          subtitle: "Start your journey with us",
        ),
        const SizedBox(height: AppSizes.spaceLg),
        AuthTextField(
          controller: _nameController,
          label: "Full Name",
          hint: "Enter your name",
          prefixIcon: Icons.person_outlined,
        ),
        const SizedBox(height: AppSizes.spaceMd),
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
          hint: "Create a password",
          obscure: true,
          prefixIcon: Icons.lock_outlined,
        ),
        const SizedBox(height: AppSizes.spaceXs),
        Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 14,
              color: AppColors.lightTextTertiary,
            ),
            const SizedBox(width: AppSizes.spaceXxs),
            Text(
              'Password must be at least 8 characters',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightTextTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceLg),
        AuthPrimaryButton(
          text: "Create Account",
          onPressed: _register,
          isLoading: _isLoading,
        ),
        const SizedBox(height: AppSizes.spaceLg),
        const AuthDivider(),
        const SizedBox(height: AppSizes.spaceLg),
        GoogleAuthButton(
          text: "Sign up with Google",
          onPressed: () =>
              ref.read(authControllerProvider.notifier).signInWithGoogle(),
        ),
        const SizedBox(height: AppSizes.spaceLg),
        AuthFooter(
          text: "Already have an account? Sign in",
          onPressed: () => context.pushReplacementNamed(AppRoutes.login),
        ),
      ],
    );
  }
}
