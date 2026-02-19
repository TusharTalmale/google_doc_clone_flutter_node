
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';

class EditorToolbar extends StatelessWidget {
  final QuillController controller;
  final bool isDark;

  const EditorToolbar({
    super.key,
    required this.controller,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceMd,
            vertical: AppSizes.spaceXs,
          ),
          decoration: BoxDecoration(
            color: isDark 
                ? AppColors.glassDark.withOpacity(0.7)
                : AppColors.glassLight.withOpacity(0.7),
            border: Border(
              bottom: BorderSide(
                color: isDark 
                    ? AppColors.glassBorderDark 
                    : AppColors.glassBorderLight,
                width: 0.5,
              ),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: QuillSimpleToolbar(
              controller: controller,
              config: QuillSimpleToolbarConfig(
                showAlignmentButtons: true,
                showBackgroundColorButton: true,
                showColorButton: true,
                showCodeBlock: true,
                showListCheck: true,
                showQuote: true,
                showIndent: true,
                showLink: true,
                showSearchButton: true,
                showSubscript: true,
                showSuperscript: true,
                headerStyleType: HeaderStyleType.original,
                buttonOptions: QuillSimpleToolbarButtonOptions(
                  base: QuillToolbarBaseButtonOptions(
                    iconTheme: QuillIconTheme(
                      iconButtonSelectedData: IconButtonData(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary.withOpacity(0.2),
                        ),
                      ),
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
