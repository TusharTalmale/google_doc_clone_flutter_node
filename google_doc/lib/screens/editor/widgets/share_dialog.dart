import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/repositories/document_repository.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:share_plus/share_plus.dart';

class ShareDialog extends ConsumerStatefulWidget {
  final String documentId;
  
  const ShareDialog({super.key, required this.documentId});

  @override
  ConsumerState<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends ConsumerState<ShareDialog> {
  final _emailController = TextEditingController();
  String _selectedRole = 'viewer';
  bool _isLoading = false;
  String? _link;
  
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: 480,
            decoration: BoxDecoration(
              color: isDark 
                  ? AppColors.glassDark.withOpacity(0.9)
                  : AppColors.glassLight.withOpacity(0.95),
              borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              border: Border.all(
                color: isDark 
                    ? AppColors.glassBorderDark 
                    : AppColors.glassBorderLight,
                width: 1.5,
              ),
              boxShadow: AppDecorations.elevatedShadow(opacity: 0.2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(AppSizes.spaceLg),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDark 
                            ? AppColors.darkDivider 
                            : AppColors.lightDivider,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.spaceXs),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                        ),
                        child: const Icon(
                          Icons.share_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppSizes.spaceSm),
                      Text(
                        'Share with others',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                
                // Content
                Padding(
                  padding: const EdgeInsets.all(AppSizes.spaceLg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email input
                      Text(
                        'Invite by email',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceXs),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter email address',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSizes.spaceMd),
                      
                      // Role selector
                      Text(
                        'Permission level',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceXs),
                      Row(
                        children: [
                          _RoleButton(
                            label: 'Viewer',
                            icon: Icons.visibility_rounded,
                            isSelected: _selectedRole == 'viewer',
                            onTap: () => setState(() => _selectedRole = 'viewer'),
                          ),
                          const SizedBox(width: AppSizes.spaceXs),
                          _RoleButton(
                            label: 'Editor',
                            icon: Icons.edit_rounded,
                            isSelected: _selectedRole == 'editor',
                            onTap: () => setState(() => _selectedRole = 'editor'),
                          ),
                          const SizedBox(width: AppSizes.spaceXs),
                          _RoleButton(
                            label: 'Commenter',
                            icon: Icons.comment_rounded,
                            isSelected: _selectedRole == 'commenter',
                            onTap: () => setState(() => _selectedRole = 'commenter'),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spaceMd),
                      
                      // Share button
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: AppDecorations.gradientButton(),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _isLoading ? null : _share,
                              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.spaceLg,
                                  vertical: AppSizes.spaceSm,
                                ),
                                child: Center(
                                  child: _isLoading 
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation(Colors.white),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.send_rounded, color: Colors.white, size: 18),
                                            SizedBox(width: AppSizes.spaceXs),
                                            Text(
                                              'Send invite',
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
                        ),
                      ),
                      
                      const SizedBox(height: AppSizes.spaceLg),
                      
                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceMd),
                            child: Text(
                              'OR',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: AppSizes.spaceLg),
                      
                      // Link sharing
                      Text(
                        'Share via link',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceXs),
                      
                      if (_link != null) 
                        _LinkBox(link: _link!, isDark: isDark)
                      else
                        OutlinedButton.icon(
                          onPressed: _generateLink,
                          icon: const Icon(Icons.link_rounded),
                          label: const Text('Generate shareable link'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _share() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;
    
    setState(() => _isLoading = true);
    
    try {
      await ref.read(documentRepositoryProvider).shareDocument(
        widget.documentId,
        email,
        _selectedRole,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Colors.white),
                const SizedBox(width: AppSizes.spaceXs),
                Text('Shared with $email'),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
          ),
        );
        _emailController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  void _generateLink() async {
    setState(() => _isLoading = true);
    
    try {
      final link = await ref.read(documentRepositoryProvider).generateShareLink(
        widget.documentId,
        'view',
      );
      
      setState(() => _link = link);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

class _RoleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppSizes.durationFast,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceXs,
            vertical: AppSizes.spaceSm,
          ),
          decoration: BoxDecoration(
            gradient: isSelected ? AppColors.primaryGradient : null,
            color: isSelected ? null : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            border: isSelected 
                ? null 
                : Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected 
                    ? Colors.white 
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: AppSizes.spaceXxs),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected 
                      ? Colors.white 
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinkBox extends StatelessWidget {
  final String link;
  final bool isDark;

  const _LinkBox({required this.link, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spaceSm),
      decoration: BoxDecoration(
        color: isDark 
            ? AppColors.darkSurfaceVariant.withOpacity(0.5)
            : AppColors.lightSurfaceVariant,
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        border: Border.all(
          color: AppColors.success.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.spaceXxs),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusXs),
            ),
            child: const Icon(
              Icons.link_rounded,
              size: 16,
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: AppSizes.spaceXs),
          Expanded(
            child: Text(
              link,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy_rounded, size: 18),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: link));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.check_rounded, color: Colors.white),
                      SizedBox(width: AppSizes.spaceXs),
                      Text('Link copied'),
                    ],
                  ),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                ),
              );
            },
            tooltip: 'Copy link',
          ),
        ],
      ),
    );
  }
}