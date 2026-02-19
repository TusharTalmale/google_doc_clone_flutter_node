import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/repositories/document_repository.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:intl/intl.dart';

final sharedDocumentsProvider = FutureProvider<List<DocumentModel>>((ref) async {
  final allDocs = await ref.read(documentRepositoryProvider).getMyDocuments();
  // Filter documents where current user is not owner but is collaborator
  return allDocs.where((doc) {
    return doc.ownerId != 'currentUserId'; 
  }).toList();
});

class SharedWithMeScreen extends ConsumerWidget {
  const SharedWithMeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharedAsync = ref.watch(sharedDocumentsProvider);
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
                gradient: AppColors.accentGradient,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: const Icon(
                Icons.folder_shared_rounded,
                color: Colors.white,
                size: AppSizes.iconSm,
              ),
            ),
            const SizedBox(width: AppSizes.spaceSm),
            const Text('Shared with me'),
          ],
        ),
      ),
      body: sharedAsync.when(
        data: (documents) {
          if (documents.isEmpty) {
            return _buildEmptyState(context);
          }
          
          return ListView.builder(
            itemCount: documents.length,
            padding: const EdgeInsets.all(AppSizes.spaceMd),
            itemBuilder: (context, index) {
              final doc = documents[index];
              return _SharedDocumentCard(document: doc, isDark: isDark);
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
                  AppColors.accent.withOpacity(0.1),
                  AppColors.secondary.withOpacity(0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.folder_shared_outlined,
              size: 56,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          Text(
            'No shared documents',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spaceXs),
          Text(
            'Documents shared with you will appear here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
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
            'Failed to load',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: AppSizes.spaceMd),
          OutlinedButton.icon(
            onPressed: () => ref.refresh(sharedDocumentsProvider),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _SharedDocumentCard extends StatefulWidget {
  final DocumentModel document;
  final bool isDark;

  const _SharedDocumentCard({
    required this.document,
    required this.isDark,
  });

  @override
  State<_SharedDocumentCard> createState() => _SharedDocumentCardState();
}

class _SharedDocumentCardState extends State<_SharedDocumentCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final collaborator = widget.document.collaborators.firstWhere(
      (c) => c.userId == 'currentUserId',
      orElse: () => const Collaborator(userId: '', role: 'viewer'),
    );
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceXs),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () => context.push('/doc/${widget.document.id}'),
          child: AnimatedContainer(
            duration: AppSizes.durationFast,
            transform: Matrix4.identity()
              ..translate(0.0, _isHovered ? -2.0 : 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AnimatedContainer(
                  duration: AppSizes.durationFast,
                  decoration: BoxDecoration(
                    color: widget.isDark 
                        ? (_isHovered ? AppColors.darkSurfaceVariant : AppColors.glassDark)
                        : (_isHovered ? AppColors.lightSurface : AppColors.glassLight),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    border: Border.all(
                      color: _isHovered 
                          ? AppColors.accent.withOpacity(0.3)
                          : (widget.isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight),
                    ),
                    boxShadow: _isHovered 
                        ? [
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.1),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(AppSizes.spaceSm),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.description_rounded,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      widget.document.title,
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
                              Icons.person_outline_rounded,
                              size: 12,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: AppSizes.spaceXxs),
                            Expanded(
                              child: Text(
                                'Shared by ${widget.document.ownerId}',
                                style: theme.textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
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
                              'Modified ${DateFormat('MMM d, y').format(widget.document.updatedAt ?? DateTime.now())}',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: _RoleChip(role: collaborator.role),
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

class _RoleChip extends StatelessWidget {
  final String role;

  const _RoleChip({required this.role});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getRoleColor(role);
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spaceXs,
        vertical: AppSizes.spaceXxs,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getRoleIcon(role),
            size: 12,
            color: color,
          ),
          const SizedBox(width: AppSizes.spaceXxs),
          Text(
            role.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'owner':
        return Icons.admin_panel_settings_rounded;
      case 'editor':
        return Icons.edit_rounded;
      case 'commenter':
        return Icons.comment_rounded;
      case 'viewer':
      default:
        return Icons.visibility_rounded;
    }
  }
}