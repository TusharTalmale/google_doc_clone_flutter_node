
import 'package:flutter/material.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'comments_tab.dart';
import 'activity_tab.dart';

class EditorRightSidebar extends StatelessWidget {
  final bool isDark;

  const EditorRightSidebar({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: isDark ? AppColors.glassDark : AppColors.glassLight,
        border: Border(
          left: BorderSide(
            color: isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight,
          ),
        ),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                  ),
                ),
              ),
              child: TabBar(
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.comment_outlined, size: 18),
                        SizedBox(width: AppSizes.spaceXxs),
                        Text('Comments'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.history_rounded, size: 18),
                        SizedBox(width: AppSizes.spaceXxs),
                        Text('Activity'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: const [
                  CommentsTab(),
                  ActivityTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
