import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/provider/collaboration_controller.dart';
import 'package:google_doc/provider/document_controller.dart';
import 'package:google_doc/screens/editor/widgets/cursor_widget.dart';
import 'package:google_doc/screens/editor/widgets/share_dialog.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';

import '../../models/presence_model.dart';

class EditorScreen extends ConsumerStatefulWidget {
  final String documentId;
  final bool isPublic;
  final String? publicToken;
  const EditorScreen({
    super.key,
    required this.documentId,
    this.isPublic = false,
    this.publicToken,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  late QuillController _quillController;
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  Timer? _saveTimer;
  StreamSubscription? _socketChangeSub;
  StreamSubscription? _quillChangeSub;
  
  @override
  void initState() {
    super.initState();
    _quillController = QuillController.basic();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDocument();
    });
  }

  void _setupSocketListener() {
    _socketChangeSub?.cancel();
    _socketChangeSub = ref.read(collaborationControllerProvider(widget.documentId).notifier)
        .deltaStream.listen((delta) {
      if (mounted) {
        _quillController.compose(
          Delta.fromJson(delta),
          _quillController.selection,
          ChangeSource.remote,
        );
      }
    });
  }

  void _loadDocument() async {
    final document = await ref.read(
      documentControllerProvider(widget.documentId).future,
    );
    if (document.content.isNotEmpty) {
      try {
        final delta = Delta.fromJson(document.content);
        _quillController.document = Document.fromDelta(delta);
      } catch (e) {
        print('Error loading document: $e');
      }
    }
    
    _setupSocketListener();
    
    _quillChangeSub?.cancel();
    _quillChangeSub = _quillController.changes.listen((change) {
      if (change.source == ChangeSource.local) {
        // 1. Send real-time update over socket
        ref.read(collaborationControllerProvider(widget.documentId).notifier)
            .sendDelta(change.change.toJson());
        
        // 2. Schedule auto-save to database
        _autoSave();
      }
    });
  }

  void _autoSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        final content = _quillController.document.toDelta().toJson();
        ref.read(documentControllerProvider(widget.documentId).notifier)
            .saveContent(content);
      }
    });
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    _socketChangeSub?.cancel();
    _quillChangeSub?.cancel();
    _quillController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final docAsync = ref.watch(documentControllerProvider(widget.documentId));
    final collabState = ref.watch(
      collaborationControllerProvider(widget.documentId),
    );
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > AppSizes.desktopBreakpoint;
    
    return Portal(
      child: Scaffold(
        appBar: _buildGlassAppBar(docAsync, isDark),
        body: Container(
          decoration: BoxDecoration(
            gradient: isDark 
                ? AppColors.backgroundGradientDark 
                : AppColors.backgroundGradientLight,
          ),
          child: Row(
            children: [
              // Main Editor
              Expanded(
                child: Column(
                  children: [
                    // Glass Toolbar
                    _buildGlassToolbar(isDark),
                    
                    // Editor
                    Expanded(
                      child: Stack(
                        children: [
                          // Paper
                          Center(
                            child: Container(
                              width: AppSizes.editorMaxWidth,
                              margin: const EdgeInsets.all(AppSizes.spaceLg),
                              decoration: BoxDecoration(
                                color: isDark 
                                    ? AppColors.darkSurface 
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                                child: QuillEditor(
                                  controller: _quillController,
                                  focusNode: _focusNode,
                                  scrollController: _scrollController,
                                  config: QuillEditorConfig(
                                    padding: const EdgeInsets.all(48),
                                    showCursor: true,
                                    embedBuilders: [],
                                    customStyles: DefaultStyles(
                                      paragraph: DefaultTextBlockStyle(
                                        TextStyle(
                                          fontSize: 14, 
                                          height: 1.6,
                                          color: isDark 
                                              ? AppColors.darkTextPrimary 
                                              : AppColors.lightTextPrimary,
                                        ),
                                        HorizontalSpacing(0, 0),
                                        VerticalSpacing(0, 0),
                                        VerticalSpacing(0, 0),
                                        null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          // Remote Cursors Overlay
                          ...collabState.presences.map((presence) {
                            if (presence.cursor == null) return const SizedBox();
                            return RemoteCursorWidget(
                              presence: presence,
                              controller: _quillController,
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Right Sidebar (Comments & Activity)
              if (isDesktop)
                _buildGlassRightSidebar(isDark),
            ],
          ),
        ),
        
        // Floating collaborator avatars
        floatingActionButton: collabState.presences.isEmpty 
            ? null 
            : _buildCollaboratorAvatars(collabState.presences),
      ),
    );
  }
  
  PreferredSizeWidget _buildGlassAppBar(AsyncValue<DocumentModel> docAsync, bool isDark) {
    final isSaving = docAsync.asData?.value.saveState?.status == 'saving';

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 16),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
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
                          onTap: () => _showRenameDialog(context, doc),
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
                                      color: isSaving 
                                          ? AppColors.warning 
                                          : AppColors.success,
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
                              onPressed: isSaving ? null : () {
                                final content = _quillController.document.toDelta().toJson();
                                ref.read(documentControllerProvider(widget.documentId).notifier)
                                    .saveContent(content);
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
                              _quillController.undo();
                            } else if (value == 'redo') {
                              _quillController.redo();
                            } else if (value == 'clear') {
                              _quillController.clear();
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
                        if (MediaQuery.of(context).size.width <= AppSizes.desktopBreakpoint)
                          IconButton(
                            icon: const Icon(Icons.comment_outlined),
                            onPressed: () => _showCommentsBottomSheet(context),
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
  
  Widget _buildGlassToolbar(bool isDark) {
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
              controller: _quillController,
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

  Widget _buildGlassRightSidebar(bool isDark) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: isDark 
            ? AppColors.glassDark 
            : AppColors.glassLight,
        border: Border(
          left: BorderSide(
            color: isDark 
                ? AppColors.glassBorderDark 
                : AppColors.glassBorderLight,
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
                    color: isDark 
                        ? AppColors.darkDivider 
                        : AppColors.lightDivider,
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
                children: [
                  _buildCommentsTab(),
                  _buildActivityTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsTab() {
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

  Widget _buildActivityTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.history_rounded,
              size: 32,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSizes.spaceMd),
          Text(
            'Activity feed coming soon',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCollaboratorAvatars(List<Presence> presences) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spaceSm,
        vertical: AppSizes.spaceXs,
      ),
      decoration: BoxDecoration(
        color: AppColors.glassDark,
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        border: Border.all(color: AppColors.glassBorderDark),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...presences.take(3).map((p) => 
            Container(
              margin: const EdgeInsets.only(right: -8),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Color(int.parse(p.color.replaceFirst('#', '0xff'))),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    p.name.substring(0, 1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (presences.length > 3)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.darkSurfaceVariant,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Text(
                  '+${presences.length - 3}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          const SizedBox(width: AppSizes.spaceXs),
          Text(
            '${presences.length} online',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showRenameDialog(BuildContext context, DocumentModel doc) {
    final controller = TextEditingController(text: doc.title);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
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
                  ref.read(documentControllerProvider(widget.documentId).notifier)
                      .updateTitle(controller.text);
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
      builder: (context) => ShareDialog(documentId: widget.documentId),
    );
  }
  
  void _showCommentsBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
            ),
            child: DraggableScrollableSheet(
              initialChildSize: 0.5,
              expand: false,
              builder: (_, controller) => Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: AppSizes.spaceSm),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                    ),
                  ),
                  Text(
                    'Comments',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(child: _buildCommentsTab()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}