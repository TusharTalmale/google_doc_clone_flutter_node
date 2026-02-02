import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  
  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
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
                color: AppColors.error.withOpacity(0.15),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: _GlowingOrb(
                size: 250,
                color: AppColors.primary.withOpacity(0.1),
              ),
            ),
            
            // Content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.spaceLg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Error Icon with glass effect
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.radiusXxl),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.error.withOpacity(0.2),
                                AppColors.error.withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(AppSizes.radiusXxl),
                            border: Border.all(
                              color: AppColors.error.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.error_outline_rounded,
                            size: 64,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceXl),
                    
                    // Title
                    Text(
                      'Oops!',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceXs),
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    
                    // Error Details
                    if (error != null) ...[
                      const SizedBox(height: AppSizes.spaceLg),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(maxWidth: 400),
                            padding: const EdgeInsets.all(AppSizes.spaceMd),
                            decoration: BoxDecoration(
                              color: isDark 
                                  ? AppColors.glassDark 
                                  : AppColors.glassLight,
                              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                              border: Border.all(
                                color: isDark 
                                    ? AppColors.glassBorderDark 
                                    : AppColors.glassBorderLight,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppSizes.spaceXxs),
                                  decoration: BoxDecoration(
                                    color: AppColors.info.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                                  ),
                                  child: const Icon(
                                    Icons.code_rounded,
                                    size: 16,
                                    color: AppColors.info,
                                  ),
                                ),
                                const SizedBox(width: AppSizes.spaceSm),
                                Expanded(
                                  child: Text(
                                    error.toString(),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontFamily: 'monospace',
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: AppSizes.spaceXl),
                    
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Go Home Button
                        Container(
                          decoration: AppDecorations.gradientButton(),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => context.go('/'),
                              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.spaceLg,
                                  vertical: AppSizes.spaceSm,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.home_rounded, color: Colors.white),
                                    SizedBox(width: AppSizes.spaceXs),
                                    Text(
                                      'Go Home',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSizes.spaceMd),
                        
                        // Go Back Button
                        OutlinedButton.icon(
                          onPressed: () => Navigator.of(context).canPop() 
                              ? Navigator.of(context).pop() 
                              : context.go('/'),
                          icon: const Icon(Icons.arrow_back_rounded),
                          label: const Text('Go Back'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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