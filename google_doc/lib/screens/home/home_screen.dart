import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/provider/document_list_controller.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:google_doc/widgets/animations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docList = ref.watch(documentListControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: docList.when(
        data: (doc) => _buildDocumentsGrid(context, ref, doc),
        error: (err, stack) => _buildErrorWidget(context, ref, err),
        loading: () => _buildShimmerLoading(context),
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
      ),
    );
  }
}

Widget _buildDocumentsGrid(
  BuildContext context,
  WidgetRef ref,
  List<DocumentModel> documents,
) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isDesktop = screenWidth > AppSizes.desktopBreakpoint;
  final isTablet = screenWidth > AppSizes.tabletBreakpoint;
  final crossAxisCount = isDesktop ? 4 : (isTablet ? 3 : 2);
  final theme = Theme.of(context);
  
  if (documents.isEmpty) {
    return _buildEmptyState(context, ref);
  }

  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceLg),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Documents",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceXxs),
                  Text(
                    '${documents.length} document${documents.length != 1 ? 's' : ''}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildViewToggle(context),
            ],
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceLg),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.78,
            mainAxisSpacing: AppSizes.spaceMd,
            crossAxisSpacing: AppSizes.spaceMd,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final document = documents[index];
            return GlassDocumentCard(
              document: document,
              onTap: () => context.push('/doc/${document.id}'),
            ).animateFadeIn(delayMs: index * 50);
          }, childCount: documents.length),
        ),
      ),
      const SliverPadding(padding: EdgeInsets.all(AppSizes.spaceXxl)),
    ],
  );
}

Widget _buildViewToggle(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  
  return Container(
    decoration: BoxDecoration(
      color: isDark 
          ? AppColors.darkSurfaceVariant.withOpacity(0.5) 
          : AppColors.lightSurfaceVariant.withOpacity(0.8),
      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ViewToggleButton(
          icon: Icons.grid_view_rounded,
          isSelected: true,
          onTap: () {},
        ),
        _ViewToggleButton(
          icon: Icons.view_list_rounded,
          isSelected: false,
          onTap: () {},
        ),
      ],
    ),
  );
}

class _ViewToggleButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ViewToggleButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppSizes.durationFast,
        padding: const EdgeInsets.all(AppSizes.spaceXs),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        ),
        child: Icon(
          icon,
          size: AppSizes.iconSm,
          color: isSelected ? Colors.white : AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}

Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
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
                  AppColors.primary.withOpacity(0.1),
                  AppColors.secondary.withOpacity(0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.description_outlined,
              size: 56,
              color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          Text(
            'No documents yet',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spaceXs),
          Text(
            'Create your first document to get started',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spaceLg),
          Container(
            decoration: AppDecorations.gradientButton(),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => ref
                    .read(documentListControllerProvider.notifier)
                    .createDocument(),
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.spaceLg,
                    vertical: AppSizes.spaceSm,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_rounded, color: Colors.white),
                      SizedBox(width: AppSizes.spaceXs),
                      Text(
                        'Create document',
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
        ],
      ),
    ),
  );
}

Widget _buildShimmerLoading(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final shimmerColors = AppColors.getShimmerColors(Theme.of(context).brightness);
  
  return Shimmer.fromColors(
    baseColor: shimmerColors.$1,
    highlightColor: shimmerColors.$2,
    child: GridView.builder(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.78,
        crossAxisSpacing: AppSizes.spaceMd,
        mainAxisSpacing: AppSizes.spaceMd,
      ),
      itemCount: 8,
      itemBuilder: (_, __) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        ),
      ),
    ),
  );
}

Widget _buildErrorWidget(BuildContext context, WidgetRef ref, Object error) {
  final theme = Theme.of(context);
  
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
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
            'Failed to load documents',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spaceXs),
          Text(
            error.toString(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spaceLg),
          OutlinedButton.icon(
            onPressed: () => ref.refresh(documentListControllerProvider),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    ),
  );
}

/// Glass Document Card
class GlassDocumentCard extends StatefulWidget {
  final DocumentModel document;
  final VoidCallback onTap;

  const GlassDocumentCard({
    super.key, 
    required this.document, 
    required this.onTap,
  });

  @override
  State<GlassDocumentCard> createState() => _GlassDocumentCardState();
}

class _GlassDocumentCardState extends State<GlassDocumentCard> {
  bool _isHovered = false;

  String _formatDate(DateTime? date) {
    if (date == null) return 'Recently';
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppSizes.durationFast,
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -4.0 : 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: _isHovered ? 15 : 10, 
                sigmaY: _isHovered ? 15 : 10,
              ),
              child: AnimatedContainer(
                duration: AppSizes.durationFast,
                decoration: BoxDecoration(
                  color: isDark 
                      ? (_isHovered ? AppColors.darkSurfaceVariant : AppColors.glassDark)
                      : (_isHovered ? AppColors.lightSurface : AppColors.glassLight),
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  border: Border.all(
                    color: _isHovered 
                        ? AppColors.primary.withOpacity(0.3)
                        : (isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight),
                    width: 1.5,
                  ),
                  boxShadow: _isHovered 
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : AppDecorations.subtleShadow(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail/Preview
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              isDark 
                                  ? AppColors.darkSurfaceVariant.withOpacity(0.5)
                                  : AppColors.lightSurfaceVariant,
                              isDark 
                                  ? AppColors.darkSurface.withOpacity(0.5)
                                  : AppColors.lightSurfaceVariant.withOpacity(0.5),
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(AppSizes.radiusLg),
                            topRight: Radius.circular(AppSizes.radiusLg),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: AnimatedScale(
                                duration: AppSizes.durationFast,
                                scale: _isHovered ? 1.1 : 1.0,
                                child: Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.primaryGradient,
                                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
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
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                            // Favorite star
                            if (widget.document.isFavorite)
                              Positioned(
                                top: AppSizes.spaceXs,
                                right: AppSizes.spaceXs,
                                child: Container(
                                  padding: const EdgeInsets.all(AppSizes.spaceXxs),
                                  decoration: BoxDecoration(
                                    color: AppColors.warning.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                                  ),
                                  child: const Icon(
                                    Icons.star_rounded,
                                    size: 16,
                                    color: AppColors.warning,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Info
                    Container(
                      padding: const EdgeInsets.all(AppSizes.spaceSm),
                      decoration: BoxDecoration(
                        color: isDark 
                            ? AppColors.darkSurface.withOpacity(0.5)
                            : Colors.white.withOpacity(0.8),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(AppSizes.radiusLg),
                          bottomRight: Radius.circular(AppSizes.radiusLg),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.document.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
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
                              Expanded(
                                child: Text(
                                  _formatDate(widget.document.updatedAt),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              if (widget.document.collaborators.isNotEmpty)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.people_outline_rounded,
                                      size: 12,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${widget.document.collaborators.length}',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
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
}
