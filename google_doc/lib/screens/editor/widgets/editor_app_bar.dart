
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/provider/document_controller.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:google_doc/screens/editor/widgets/share_dialog.dart';

class EditorAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String documentId;
  final QuillController quillController;
  final VoidCallback? onCommentsTap;

  const EditorAppBar({
    super.key,
    required this.documentId,
    required this.quillController,
    this.onCommentsTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docAsync = ref.watch(documentControllerProvider(documentId));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSaving = docAsync.asData?.value.saveState?.status == 'saving';

    return PreferredSize(
      preferredSize: preferredSize,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.glassDark : AppColors.glassLight,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spaceMd,
                  vertical: AppSizes.spaceXs,
                ),
                child: Row(
                  children: [
                    // Back button
                    Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkSurfaceVariant.withOpacity(0.5)
                            : AppColors.lightSurfaceVariant,
                        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: () => context.pop(),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceSm),

                    // Title
                    Expanded(
                      child: docAsync.when(
                        data: (doc) => GestureDetector(
                          onTap: () => _showRenameDialog(context, ref, doc, isDark),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                doc.title,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: isSaving ? AppColors.warning : AppColors.success,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: AppSizes.spaceXxs),
                                  Text(
                                    isSaving ? 'Saving...' : 'All changes saved',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        loading: () => const Text('Loading...'),
                        error: (_, __) => const Text('Error'),
                      ),
                    ),

                    // Actions
                    Row(
                      children: [
                        // Save Button
                        if (docAsync.asData != null)
                          Container(
                            margin: const EdgeInsets.only(left: AppSizes.spaceXs),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkSurfaceVariant.withOpacity(0.5)
                                  : AppColors.lightSurfaceVariant,
                              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                            ),
                            child: IconButton(
                              icon: Icon(
                                isSaving ? Icons.sync_rounded : Icons.save_outlined,
                                color: isSaving ? AppColors.primary : null,
                                size: 20,
                              ),
                              onPressed: isSaving
                                  ? null
                                  : () {
                                      final content = quillController.document.toDelta().toJson();
                                      ref.read(documentControllerProvider(documentId).notifier).saveContent(content);
                                    },
                              tooltip: 'Save changes',
                            ),
                          ),

                        // Edit Menu
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.edit_note_rounded),
                          tooltip: 'Edit options',
                          onSelected: (value) {
                            if (value == 'undo') {
                              quillController.undo();
                            } else if (value == 'redo') {
                              quillController.redo();
                            } else if (value == 'clear') {
                              quillController.clear();
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'undo',
                              child: ListTile(
                                leading: Icon(Icons.undo_rounded),
                                title: Text('Undo'),
                                trailing: Text('Ctrl+Z'),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'redo',
                              child: ListTile(
                                leading: Icon(Icons.redo_rounded),
                                title: Text('Redo'),
                                trailing: Text('Ctrl+Y'),
                              ),
                            ),
                            const PopupMenuDivider(),
                            const PopupMenuItem(
                              value: 'thumbnail',
                              child: ListTile(
                                leading: Icon(Icons.image_rounded),
                                title: Text('Update Thumbnail'),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'clear',
                              child: ListTile(
                                leading: Icon(Icons.clear_all_rounded, color: Colors.red),
                                title: Text('Clear All', style: TextStyle(color: Colors.red)),
                              ),
                            ),
                          ],
                        ),

                        // Comments Toggle (Mobile)
                        if (MediaQuery.of(context).size.width <= AppSizes.desktopBreakpoint && onCommentsTap != null)
                          IconButton(
                            icon: const Icon(Icons.comment_outlined),
                            onPressed: onCommentsTap,
                          ),

                        // Share Button
                        Container(
                          margin: const EdgeInsets.only(left: AppSizes.spaceXs),
                          decoration: AppDecorations.gradientButton(borderRadius: AppSizes.radiusSm),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _showShareDialog(context),
                              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.spaceMd,
                                  vertical: AppSizes.spaceXs,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.share_rounded, color: Colors.white, size: 18),
                                    SizedBox(width: AppSizes.spaceXxs),
                                    Text(
                                      'Share',
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

                        // Profile
                        Container(
                          margin: const EdgeInsets.only(left: AppSizes.spaceSm),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            gradient: AppColors.accentGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              'U',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showRenameDialog(BuildContext context, WidgetRef ref, DocumentModel doc, bool isDark) {
    final controller = TextEditingController(text: doc.title);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.spaceXs),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: const Icon(Icons.edit_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: AppSizes.spaceSm),
            const Text('Rename document'),
          ],
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Document title',
          ),
          autofocus: true,
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          Container(
            decoration: AppDecorations.gradientButton(borderRadius: AppSizes.radiusSm),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ref.read(documentControllerProvider(documentId).notifier).updateTitle(controller.text);
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.spaceMd,
                    vertical: AppSizes.spaceXs,
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ShareDialog(documentId: documentId),
    );
  }
}
