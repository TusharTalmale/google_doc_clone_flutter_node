import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/provider/document_list_controller.dart';
import 'package:google_doc/repositories/document_repository.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:intl/intl.dart';

final trashDocumentsProvider = FutureProvider<List<DocumentModel>>((ref) async {
  return ref.read(documentRepositoryProvider).getTrash();
});

class TrashScreen extends ConsumerWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trashAsync = ref.watch(trashDocumentsProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.spaceXs),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.error,
                size: AppSizes.iconSm,
              ),
            ),
            const SizedBox(width: AppSizes.spaceSm),
            const Text('Trash'),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: AppSizes.spaceMd),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: TextButton.icon(
              onPressed: () => _emptyTrash(context, ref),
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: AppColors.error,
                size: AppSizes.iconSm,
              ),
              label: const Text(
                'Empty trash',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ),
        ],
      ),
      body: trashAsync.when(
        data: (documents) {
          if (documents.isEmpty) {
            return _buildEmptyState(context);
          }
          
          return ListView.builder(
            itemCount: documents.length,
            padding: const EdgeInsets.all(AppSizes.spaceMd),
            itemBuilder: (context, index) {
              final doc = documents[index];
              return _buildTrashItem(context, ref, doc, isDark);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => _buildErrorState(context, ref, error),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.error.withOpacity(0.1),
                  AppColors.error.withOpacity(0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              size: 56,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          Text(
            'Trash is empty',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spaceXs),
          Text(
            'Deleted documents will appear here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.errorLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              size: 40,
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          Text(
            'Failed to load trash',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: AppSizes.spaceMd),
          OutlinedButton.icon(
            onPressed: () => ref.refresh(trashDocumentsProvider),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildTrashItem(BuildContext context, WidgetRef ref, DocumentModel doc, bool isDark) {
    final deleteDate = doc.deletedAt ?? DateTime.now();
    final daysRemaining = 30 - DateTime.now().difference(deleteDate).inDays;
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceXs),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => _restoreDocument(context, ref, doc.id),
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              icon: Icons.restore_rounded,
              label: 'Restore',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizes.radiusMd),
                bottomLeft: Radius.circular(AppSizes.radiusMd),
              ),
            ),
            SlidableAction(
              onPressed: (_) => _deleteForever(context, ref, doc.id),
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              icon: Icons.delete_forever_rounded,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(AppSizes.radiusMd),
                bottomRight: Radius.circular(AppSizes.radiusMd),
              ),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
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
              child: ListTile(
                contentPadding: const EdgeInsets.all(AppSizes.spaceSm),
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.error.withOpacity(0.2),
                        AppColors.error.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    color: AppColors.error,
                  ),
                ),
                title: Text(
                  doc.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSizes.spaceXxs),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSizes.spaceXxs),
                        Text(
                          'Deleted ${DateFormat('MMM d, y').format(deleteDate)}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceXxs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.spaceXs,
                        vertical: AppSizes.spaceXxs,
                      ),
                      decoration: BoxDecoration(
                        color: daysRemaining <= 7 
                            ? AppColors.error.withOpacity(0.1)
                            : AppColors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                      ),
                      child: Text(
                        'Auto-delete in $daysRemaining days',
                        style: TextStyle(
                          fontSize: 11,
                          color: daysRemaining <= 7 
                              ? AppColors.error 
                              : AppColors.warningDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  onSelected: (value) {
                    if (value == 'restore') {
                      _restoreDocument(context, ref, doc.id);
                    } else if (value == 'delete') {
                      _deleteForever(context, ref, doc.id);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'restore',
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSizes.spaceXxs),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                            ),
                            child: const Icon(
                              Icons.restore_rounded,
                              size: 16,
                              color: AppColors.success,
                            ),
                          ),
                          const SizedBox(width: AppSizes.spaceXs),
                          const Text('Restore'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSizes.spaceXxs),
                            decoration: BoxDecoration(
                              color: AppColors.error.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                            ),
                            child: const Icon(
                              Icons.delete_forever_rounded,
                              size: 16,
                              color: AppColors.error,
                            ),
                          ),
                          const SizedBox(width: AppSizes.spaceXs),
                          const Text('Delete forever'),
                        ],
                      ),
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

  Future<void> _restoreDocument(BuildContext context, WidgetRef ref, String id) async {
    try {
      await ref.read(documentRepositoryProvider).restoreFromTrash(id);
      ref.invalidate(trashDocumentsProvider);
      ref.invalidate(documentListControllerProvider);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Colors.white),
                const SizedBox(width: AppSizes.spaceXs),
                const Text('Document restored'),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _deleteForever(BuildContext context, WidgetRef ref, String id) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final confirm = await showDialog<bool>(
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
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: const Icon(
                Icons.warning_rounded,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: AppSizes.spaceSm),
            const Text('Delete forever?'),
          ],
        ),
        content: const Text(
          'This action cannot be undone. The document will be permanently deleted.',
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await ref.read(documentRepositoryProvider).deleteDocument(id);
        ref.invalidate(trashDocumentsProvider);
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Document deleted permanently'),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  Future<void> _emptyTrash(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
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
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: const Icon(
                Icons.delete_forever_rounded,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: AppSizes.spaceSm),
            const Text('Empty trash?'),
          ],
        ),
        content: const Text(
          'All items in trash will be permanently deleted. This action cannot be undone.',
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Empty trash'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Trash emptied'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          ),
        ),
      );
    }
  }
}