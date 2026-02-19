import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:google_doc/utils/route_constants.dart';
import '../../provider/auth_controller.dart';
import '../../widgets/auth_widgets.dart';

class _RegisterFormControllers {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
  }
}

final _registerFormProvider = Provider.autoDispose<_RegisterFormControllers>((
  ref,
) {
  final controllers = _RegisterFormControllers();
  ref.onDispose(controllers.dispose);
  return controllers;
});

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final controllers = ref.watch(_registerFormProvider);
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
        error: (_, __) => _form(context, ref, controllers, isLoading),
        data: (_) => _form(context, ref, controllers, isLoading),
      ),
    );
  }

  Widget _form(
    BuildContext context,
    WidgetRef ref,
    _RegisterFormControllers controllers,
    bool isLoading,
  ) {
    return AuthCard(
      children: [
        const AuthHeader(
          title: "Create Account",
          subtitle: "Start your journey with us",
        ),
        const SizedBox(height: AppSizes.spaceLg),
        AuthTextField(
          controller: controllers.name,
          label: "Full Name",
          hint: "Enter your name",
          prefixIcon: Icons.person_outlined,
        ),
        const SizedBox(height: AppSizes.spaceMd),
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
          onPressed: () {
            ref
                .read(authControllerProvider.notifier)
                .register(
                  controllers.name.text.trim(),
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
