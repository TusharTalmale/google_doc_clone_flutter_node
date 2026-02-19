
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'comments_tab.dart';

class CommentsBottomSheet extends StatelessWidget {
  const CommentsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppSizes.radiusXl),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.glassDark : AppColors.glassLight,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSizes.radiusXl),
            ),
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            expand: false,
            builder: (_, controller) => Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: AppSizes.spaceSm),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                ),
                Text(
                  'Comments',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Expanded(child: CommentsTab()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
