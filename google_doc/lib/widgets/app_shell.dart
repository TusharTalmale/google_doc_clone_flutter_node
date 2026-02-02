import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/models/user_model.dart';
import 'package:google_doc/provider/auth_controller.dart';
import 'package:google_doc/provider/connection_state_provider.dart';
import 'package:google_doc/provider/document_list_controller.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';

class AppShell extends ConsumerStatefulWidget {
  final Widget child;
  
  const AppShell({super.key, required this.child});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> with SingleTickerProviderStateMixin {
  bool _isSidebarExpanded = true;
  late AnimationController _animationController;
  late Animation<double> _sidebarAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppSizes.durationNormal,
      vsync: this,
    );
    _sidebarAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    if (_isSidebarExpanded) {
      _animationController.value = 1.0;
    }
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
      if (_isSidebarExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final isOnline = ref.watch(isOnlineProvider);
    final user = ref.watch(authControllerProvider).value;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > AppSizes.desktopBreakpoint;
    final isTablet = screenWidth > AppSizes.tabletBreakpoint;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark 
              ? AppColors.backgroundGradientDark 
              : AppColors.backgroundGradientLight,
        ),
        child: Row(
          children: [
            // Sidebar
            if (isDesktop)
              AnimatedBuilder(
                animation: _sidebarAnimation,
                builder: (context, child) {
                  final width = _isSidebarExpanded 
                      ? AppSizes.sidebarWidth 
                      : AppSizes.sidebarCollapsedWidth;
                  return SizedBox(
                    width: width,
                    child: _buildGlassSidebar(user, isDark),
                  );
                },
              ),
            
            // Main Content
            Expanded(
              child: Column(
                children: [
                  // Offline Banner
                  if (!isOnline)
                    _buildOfflineBanner(isDark),
                  
                  // App Bar (Mobile/Tablet)
                  if (!isDesktop) 
                    _buildGlassAppBar(user, isDark),
                  
                  // Content
                  Expanded(
                    child: ClipRRect(
                      borderRadius: isDesktop 
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(AppSizes.radiusXl),
                            )
                          : BorderRadius.zero,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark 
                              ? AppColors.darkBackground 
                              : AppColors.lightBackground,
                        ),
                        child: widget.child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Mobile Navigation
      bottomNavigationBar: !isTablet ? _buildGlassBottomNav(isDark) : null,
      
      // FAB
      floatingActionButton: _buildGradientFAB(),
    );
  }
  
  Widget _buildOfflineBanner(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.spaceXs,
        horizontal: AppSizes.spaceMd,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.warning.withOpacity(0.2),
            AppColors.warning.withOpacity(0.1),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.warning.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: AppSizes.iconSm,
            color: AppColors.warningDark,
          ),
          const SizedBox(width: AppSizes.spaceXs),
          Text(
            'Working offline. Changes will sync when connected.',
            style: TextStyle(
              color: AppColors.warningDark,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildGlassSidebar(UserModel? user, bool isDark) {
    final location = GoRouterState.of(context).matchedLocation;
    
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: isDark 
                ? AppColors.glassDark 
                : AppColors.glassLight,
            border: Border(
              right: BorderSide(
                color: isDark 
                    ? AppColors.glassBorderDark 
                    : AppColors.glassBorderLight,
              ),
            ),
          ),
          child: Column(
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.all(AppSizes.spaceMd),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      ),
                      child: const Icon(
                        Icons.description_rounded,
                        color: Colors.white,
                        size: AppSizes.iconSm,
                      ),
                    ),
                    if (_isSidebarExpanded) ...[
                      const SizedBox(width: AppSizes.spaceSm),
                      Expanded(
                        child: Text(
                          'Docs',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_left_rounded),
                        onPressed: _toggleSidebar,
                        tooltip: 'Collapse sidebar',
                      ),
                    ] else
                      IconButton(
                        icon: const Icon(Icons.chevron_right_rounded),
                        onPressed: _toggleSidebar,
                        tooltip: 'Expand sidebar',
                        padding: const EdgeInsets.only(left: AppSizes.spaceXs),
                      ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppSizes.spaceXs),
              
              // New Button
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _isSidebarExpanded ? AppSizes.spaceMd : AppSizes.spaceXs,
                ),
                child: _buildNewDocumentButton(),
              ),
              
              const SizedBox(height: AppSizes.spaceLg),
              
              // Nav Items
              _buildGlassNavItem(
                icon: Icons.description_outlined,
                activeIcon: Icons.description_rounded,
                label: 'My documents',
                isActive: location == '/',
                onTap: () => context.go('/'),
              ),
              _buildGlassNavItem(
                icon: Icons.folder_shared_outlined,
                activeIcon: Icons.folder_shared_rounded,
                label: 'Shared with me',
                isActive: location == '/shared',
                onTap: () => context.go('/shared'),
              ),
              _buildGlassNavItem(
                icon: Icons.star_outline_rounded,
                activeIcon: Icons.star_rounded,
                label: 'Starred',
                isActive: false,
                onTap: () {},
              ),
              _buildGlassNavItem(
                icon: Icons.delete_outline_rounded,
                activeIcon: Icons.delete_rounded,
                label: 'Trash',
                isActive: location == '/trash',
                onTap: () => context.go('/trash'),
              ),
              
              const Spacer(),
              
              // User Profile
              if (user != null)
                _buildUserProfileTile(user, isDark),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildNewDocumentButton() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (_isSidebarExpanded) {
      return Container(
        decoration: AppDecorations.gradientButton(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _createNewDocument(context),
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spaceMd,
                vertical: AppSizes.spaceSm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_rounded, color: Colors.white),
                  SizedBox(width: AppSizes.spaceXs),
                  Text(
                    'New document',
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
      );
    }
    
    return Container(
      width: 48,
      height: 48,
      decoration: AppDecorations.gradientButton(borderRadius: AppSizes.radiusSm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _createNewDocument(context),
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          child: const Icon(Icons.add_rounded, color: Colors.white),
        ),
      ),
    );
  }
  
  Widget _buildGlassNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _isSidebarExpanded ? AppSizes.spaceXs : AppSizes.spaceXxs,
        vertical: AppSizes.spaceXxs,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          child: AnimatedContainer(
            duration: AppSizes.durationFast,
            padding: EdgeInsets.symmetric(
              horizontal: _isSidebarExpanded ? AppSizes.spaceMd : AppSizes.spaceSm,
              vertical: AppSizes.spaceSm,
            ),
            decoration: BoxDecoration(
              gradient: isActive 
                  ? LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.15),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    )
                  : null,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              border: isActive 
                  ? Border.all(
                      color: AppColors.primary.withOpacity(0.2),
                    )
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  isActive ? activeIcon : icon,
                  color: isActive 
                      ? AppColors.primary 
                      : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                  size: AppSizes.iconMd,
                ),
                if (_isSidebarExpanded) ...[
                  const SizedBox(width: AppSizes.spaceSm),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isActive 
                            ? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary)
                            : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildUserProfileTile(UserModel user, bool isDark) {
    return Container(
      margin: const EdgeInsets.all(AppSizes.spaceXs),
      decoration: BoxDecoration(
        color: isDark 
            ? AppColors.darkSurfaceVariant.withOpacity(0.5) 
            : AppColors.lightSurfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: _isSidebarExpanded ? AppSizes.spaceSm : AppSizes.spaceXs,
          vertical: AppSizes.spaceXxs,
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            shape: BoxShape.circle,
          ),
          child: user.profilePic != null 
              ? ClipOval(
                  child: Image.network(
                    user.profilePic!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Center(
                      child: Text(
                        user.name?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    user.name?.substring(0, 1).toUpperCase() ?? 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
        ),
        title: _isSidebarExpanded 
            ? Text(
                user.name ?? 'User',
                style: Theme.of(context).textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        subtitle: _isSidebarExpanded 
            ? Text(
                user.email,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: _isSidebarExpanded 
            ? IconButton(
                icon: Icon(
                  Icons.logout_rounded,
                  color: AppColors.error,
                  size: AppSizes.iconSm,
                ),
                onPressed: () => ref.read(authControllerProvider.notifier).logout(),
                tooltip: 'Logout',
              )
            : null,
        onTap: _isSidebarExpanded ? null : () => _showUserMenu(context),
      ),
    );
  }
  
  Widget _buildGlassAppBar(UserModel? user, bool isDark) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          decoration: BoxDecoration(
            color: isDark 
                ? AppColors.glassDark 
                : AppColors.glassLight,
            border: Border(
              bottom: BorderSide(
                color: isDark 
                    ? AppColors.glassBorderDark 
                    : AppColors.glassBorderLight,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spaceMd,
              vertical: AppSizes.spaceXs,
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: const Icon(
                    Icons.description_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSizes.spaceSm),
                Text(
                  'Google Docs',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {},
                ),
                GestureDetector(
                  onTap: () => _showUserMenu(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        user?.name?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildGlassBottomNav(bool isDark) {
    final location = GoRouterState.of(context).matchedLocation;
    
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: isDark 
                ? AppColors.glassDark 
                : AppColors.glassLight,
            border: Border(
              top: BorderSide(
                color: isDark 
                    ? AppColors.glassBorderDark 
                    : AppColors.glassBorderLight,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomNavItem(
                    icon: Icons.description_outlined,
                    activeIcon: Icons.description_rounded,
                    label: 'Docs',
                    isActive: location == '/',
                    onTap: () => context.go('/'),
                  ),
                  _buildBottomNavItem(
                    icon: Icons.folder_shared_outlined,
                    activeIcon: Icons.folder_shared_rounded,
                    label: 'Shared',
                    isActive: location == '/shared',
                    onTap: () => context.go('/shared'),
                  ),
                  _buildBottomNavItem(
                    icon: Icons.delete_outline_rounded,
                    activeIcon: Icons.delete_rounded,
                    label: 'Trash',
                    isActive: location == '/trash',
                    onTap: () => context.go('/trash'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBottomNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppSizes.durationFast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceMd,
          vertical: AppSizes.spaceXs,
        ),
        decoration: BoxDecoration(
          gradient: isActive 
              ? LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.15),
                    AppColors.primary.withOpacity(0.05),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.primary : AppColors.lightTextSecondary,
            ),
            const SizedBox(height: AppSizes.spaceXxs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildGradientFAB() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _createNewDocument(context),
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.spaceMd,
              vertical: AppSizes.spaceSm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_rounded, color: Colors.white),
                SizedBox(width: AppSizes.spaceXs),
                Text(
                  'New',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _createNewDocument(BuildContext context) async {
    // Show loading with glass effect
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(AppSizes.spaceLg),
              decoration: AppDecorations.getGlassCard(Theme.of(context).brightness),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: AppSizes.spaceMd),
                  Text('Creating document...'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
    try {
      await ref.read(documentListControllerProvider.notifier).createDocument();
      
      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
  
  void _showUserMenu(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusXl),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: isDark 
                  ? AppColors.glassDark 
                  : AppColors.glassLight,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSizes.radiusXl),
              ),
              border: Border.all(
                color: isDark 
                    ? AppColors.glassBorderDark 
                    : AppColors.glassBorderLight,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: AppSizes.spaceSm),
                    decoration: BoxDecoration(
                      color: isDark 
                          ? AppColors.darkDivider 
                          : AppColors.lightDivider,
                      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(AppSizes.spaceXs),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      ),
                      child: Icon(Icons.person_rounded, color: AppColors.primary),
                    ),
                    title: const Text('Profile'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(AppSizes.spaceXs),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      ),
                      child: Icon(Icons.settings_rounded, color: AppColors.secondary),
                    ),
                    title: const Text('Settings'),
                    onTap: () => Navigator.pop(context),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(AppSizes.spaceXs),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      ),
                      child: Icon(Icons.logout_rounded, color: AppColors.error),
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: AppColors.error),
                    ),
                    onTap: () {
                      ref.read(authControllerProvider.notifier).logout();
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: AppSizes.spaceMd),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}