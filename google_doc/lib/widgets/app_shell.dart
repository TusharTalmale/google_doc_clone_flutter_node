import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/models/user_model.dart';
import 'package:google_doc/provider/auth_controller.dart';
import 'package:google_doc/provider/connection_state_provider.dart';
import 'package:google_doc/provider/document_list_controller.dart';
import 'package:google_doc/utils/app_theme.dart';

class AppShell extends ConsumerStatefulWidget {
  final Widget child;
  
  const AppShell({super.key, required this.child});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  bool _isSidebarExpanded = true;
  
  @override
  Widget build(BuildContext context) {
    final isOnline = ref.watch(isOnlineProvider);
    final user = ref.watch(authControllerProvider).value;
    final isDesktop = MediaQuery.of(context).size.width > 1200;
    
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            width: isDesktop 
                ? (_isSidebarExpanded ? 280 : 72)
                : 0,
            child: isDesktop ? _buildSidebar(user) : null,
          ),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Offline Banner
                if (!isOnline)
                  Container(
                    width: double.infinity,
                    color: Colors.orange.shade100,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.cloud_off, size: 16, color: Colors.orange.shade800),
                        const SizedBox(width: 8),
                        Text(
                          'Working offline. Changes will sync when connected.',
                          style: TextStyle(
                            color: Colors.orange.shade800,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // App Bar (Mobile/Tablet)
                if (!isDesktop) _buildMobileAppBar(user),
                
                // Content
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
      
      // Mobile Navigation
      bottomNavigationBar: !isDesktop ? _buildBottomNav() : null,
      
      // FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createNewDocument(context),
        icon: const Icon(Icons.add),
        label: const Text('New'),
      ),
    );
  }
  
  Widget _buildSidebar(UserModel? user) {
    final location = GoRouterState.of(context).matchedLocation;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const FlutterLogo(size: 32),
                if (_isSidebarExpanded) ...[
                  const SizedBox(width: 12),
                  Text(
                    'Docs',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => setState(() => _isSidebarExpanded = false),
                  ),
                ],
              ],
            ),
          ),
          
          const Divider(),
          
          // New Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () => _createNewDocument(context),
              icon: const Icon(Icons.add),
              label: _isSidebarExpanded ? const Text('New document') : const SizedBox(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                elevation: 1,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          
          // Nav Items
          _buildNavItem(
            icon: Icons.description_outlined,
            label: 'My documents',
            isActive: location == '/',
            onTap: () => context.go('/'),
          ),
          _buildNavItem(
            icon: Icons.folder_shared_outlined,
            label: 'Shared with me',
            isActive: location == '/shared',
            onTap: () => context.go('/shared'),
          ),
          _buildNavItem(
            icon: Icons.star_border,
            label: 'Starred',
            isActive: false,
            onTap: () {},
          ),
          _buildNavItem(
            icon: Icons.delete_outline,
            label: 'Trash',
            isActive: location == '/trash',
            onTap: () => context.go('/trash'),
          ),
          
          const Spacer(),
          
          // User Profile
          if (user != null)
            ListTile(
              leading: CircleAvatar(
                backgroundImage: user.profilePic != null 
                    ? NetworkImage(user.profilePic!)
                    : null,
                child: user.profilePic == null 
                    ? Text(user.name?.substring(0, 1) ?? 'U')
                    : null,
              ),
              title: _isSidebarExpanded ? Text(user.name ?? 'User') : null,
              subtitle: _isSidebarExpanded ? Text(user.email, overflow: TextOverflow.ellipsis) : null,
              trailing: _isSidebarExpanded 
                  ? IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () => ref.read(authControllerProvider.notifier).logout(),
                    )
                  : null,
              onTap: _isSidebarExpanded ? null : () => _showUserMenu(context),
            ),
        ],
      ),
    );
  }
  
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppColors.primary : AppColors.secondary,
      ),
      title: _isSidebarExpanded ? Text(label) : null,
      selected: isActive,
      selectedTileColor: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_isSidebarExpanded ? 0 : 12),
      ),
      onTap: onTap,
    );
  }
  
  Widget _buildMobileAppBar(UserModel? user) {
    return AppBar(
      title: const Text('Google Docs'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: CircleAvatar(
            radius: 14,
            child: Text(user?.name?.substring(0, 1) ?? 'U'),
          ),
          onPressed: () => _showUserMenu(context),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
  
  Widget _buildBottomNav() {
    final location = GoRouterState.of(context).matchedLocation;
    
    return NavigationBar(
      selectedIndex: location == '/' ? 0 : location == '/shared' ? 1 : 2,
      onDestinationSelected: (index) {
        switch (index) {
          case 0: context.go('/');
          case 1: context.go('/shared');
          case 2: context.go('/trash');
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.description_outlined),
          label: 'Docs',
        ),
        NavigationDestination(
          icon: Icon(Icons.folder_shared_outlined),
          label: 'Shared',
        ),
        NavigationDestination(
          icon: Icon(Icons.delete_outline),
          label: 'Trash',
        ),
      ],
    );
  }
  
  void _createNewDocument(BuildContext context) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    
    try {
      // Create document
      await ref.read(documentListControllerProvider.notifier).createDocument();
      
      if (context.mounted) {
        Navigator.pop(context); // Close loading
        // Navigate to new document ( you'd get the ID from the creation response)
        // For now, refresh list
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
  
  void _showUserMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                ref.read(authControllerProvider.notifier).logout();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}