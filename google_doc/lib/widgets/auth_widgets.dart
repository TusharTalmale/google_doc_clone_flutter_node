import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'google_sign_in_stub.dart'
    if (dart.library.js_interop) 'package:google_sign_in_web/web_only.dart'
    as web;

/// ---------- GRADIENT BACKGROUND ----------
class GradientBackground extends StatelessWidget {
  final Widget child;
  
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        gradient: isDark 
            ? AppColors.backgroundGradientDark 
            : AppColors.backgroundGradientLight,
      ),
      child: Stack(
        children: [
          // Decorative orbs
          Positioned(
            top: -100,
            right: -100,
            child: _GlowingOrb(
              size: 300,
              color: AppColors.primary.withOpacity(0.15),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _GlowingOrb(
              size: 250,
              color: AppColors.secondary.withOpacity(0.12),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            right: -80,
            child: _GlowingOrb(
              size: 200,
              color: AppColors.accent.withOpacity(0.1),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _GlowingOrb extends StatelessWidget {
  final double size;
  final Color color;
  
  const _GlowingOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0)],
        ),
      ),
    );
  }
}

/// ---------- GLASS AUTH CARD ----------
class AuthCard extends StatelessWidget {
  final List<Widget> children;

  const AuthCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GradientBackground(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.spaceLg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark 
                        ? AppColors.glassDark 
                        : AppColors.glassLight,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                    border: Border.all(
                      color: isDark 
                          ? AppColors.glassBorderDark 
                          : AppColors.glassBorderLight,
                      width: 1.5,
                    ),
                    boxShadow: AppDecorations.elevatedShadow(
                      opacity: isDark ? 0.3 : 0.1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.spaceXl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: children,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------- AUTH HEADER ----------
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        // Logo with gradient background
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.description_rounded,
            size: 36,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppSizes.spaceLg),
        Text(
          title, 
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.spaceXs),
        Text(
          subtitle, 
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// ---------- AUTH GRADIENT BUTTON ----------
class AuthPrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const AuthPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  State<AuthPrimaryButton> createState() => _AuthPrimaryButtonState();
}

class _AuthPrimaryButtonState extends State<AuthPrimaryButton> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: 56,
          decoration: AppDecorations.gradientButton(),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isLoading ? null : widget.onPressed,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              child: Center(
                child: widget.isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        widget.text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------- AUTH DIVIDER ----------
class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.dividerColor.withOpacity(0),
                  theme.dividerColor,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceMd),
          child: Text(
            "OR",
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              letterSpacing: 1,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.dividerColor,
                  theme.dividerColor.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------- GOOGLE AUTH BUTTON ----------
class GoogleAuthButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const GoogleAuthButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<GoogleAuthButton> createState() => _GoogleAuthButtonState();
}

class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return web.renderButton();
    }
    
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppSizes.durationFast,
        height: 56,
        decoration: BoxDecoration(
          color: _isHovered 
              ? (isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant)
              : (isDark ? AppColors.darkSurface : AppColors.lightSurface),
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1.5,
          ),
          boxShadow: _isHovered 
              ? AppDecorations.subtleShadow() 
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google logo
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://www.google.com/favicon.ico',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceSm),
                Text(
                  widget.text,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------- AUTH FOOTER ----------
class AuthFooter extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AuthFooter({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceMd,
            vertical: AppSizes.spaceXs,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

/// ---------- AUTH TEXT FIELD ----------
class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool obscure;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.obscure = false,
    this.keyboardType,
    this.prefixIcon,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _isFocused = false;
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return AnimatedContainer(
      duration: AppSizes.durationFast,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        boxShadow: _isFocused 
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: TextField(
          controller: widget.controller,
          obscureText: widget.obscure ? _isObscured : false,
          keyboardType: widget.keyboardType,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon != null 
                ? Icon(
                    widget.prefixIcon,
                    color: _isFocused 
                        ? AppColors.primary 
                        : (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
                  )
                : null,
            suffixIcon: widget.obscure
                ? IconButton(
                    icon: Icon(
                      _isObscured 
                          ? Icons.visibility_outlined 
                          : Icons.visibility_off_outlined,
                      color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                    ),
                    onPressed: () => setState(() => _isObscured = !_isObscured),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
