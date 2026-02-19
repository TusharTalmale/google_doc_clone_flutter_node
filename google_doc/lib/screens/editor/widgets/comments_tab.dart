
import 'package:flutter/material.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';

class CommentsTab extends StatelessWidget {
  const CommentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.spaceMd),
      itemCount: 0,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSizes.spaceSm),
          decoration: BoxDecoration(
            color: isDark 
                ? AppColors.darkSurfaceVariant.withOpacity(0.5)
                : AppColors.lightSurfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.spaceSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'A',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceXs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Name',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '2 hours ago',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, size: 18),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceXs),
                const Text('This is a comment on the document.'),
              ],
            ),
          ),
        );
      },
    );
  }
}
