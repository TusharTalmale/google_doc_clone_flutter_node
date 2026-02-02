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
  @override
  void initState() {
    super.initState();
    _quillController = QuillController.basic();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDocument();
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
    _quillController.addListener(_onDocumentChanged);
  }

  void _onDocumentChanged() {
    // Debounce save
    // This will be handled by Yjs in real implementation
  }

  @override
  void dispose() {
    _quillController.removeListener(_onDocumentChanged);
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
      return Portal(
      child: Scaffold(
        appBar: _buildAppBar(docAsync),
        body: Row(
          children: [
            // Main Editor
            Expanded(
              child: Column(
                children: [
                  // Toolbar
                  QuillSimpleToolbar(
                    controller: _quillController,
                    config : const QuillSimpleToolbarConfig(
                      showAlignmentButtons: true,
                      showBackgroundColorButton: true,
                      showColorButton: true,
                      showCodeBlock: true,
                      showListCheck: true,
                      showQuote: true,
                    ),
                  ),
                  
                  // Editor
                  Expanded(
                    child: Stack(
                      children: [
                        // Page
                        Center(
                          child: Container(
                            width: AppSizes.editorMaxWidth,
                            margin: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRect(
                              child: QuillEditor(
                                controller: _quillController,
                                focusNode: _focusNode,
                                scrollController: _scrollController,
                                config : QuillEditorConfig(
                                  padding: const EdgeInsets.all(48),
                                  showCursor: true,
                                  embedBuilders: [],
                                  customStyles: DefaultStyles(
                                    paragraph: DefaultTextBlockStyle(
                                      const TextStyle(fontSize: 14, height: 1.5),
                                      HorizontalSpacing(0, 0),
                                      VerticalSpacing(0, 0),
                                      VerticalSpacing(0, 0),
                                      null,
                                    
                                    ).copyWith(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
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
            if (MediaQuery.of(context).size.width > 1200)
              Container(
                width: 300,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: _buildRightSidebar(),
              ),
          ],
        ),
        
        // Floating collaborator avatars
        floatingActionButton: collabState.presences.isEmpty 
            ? null 
            : _buildCollaboratorAvatars(collabState.presences),
      ),
    );
  }
  

  PreferredSizeWidget _buildAppBar(AsyncValue<DocumentModel> docAsync) {
    final isSaving = docAsync.asData?.value.saveState?.status == 'saving';

    return AppBar(
      title: Row(
        children: [
          // Back button
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),

          // Title
          Expanded(
            child: docAsync.when(
              data: (doc) => InkWell(
                onTap: () => _showRenameDialog(context, doc),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.title,
                      style: const TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      isSaving ? 'Saving...' : 'All changes saved',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => const Text('Loading...'),
              error: (_, __) => const Text('Error'),
            ),
          ),
        ],
      ),
      actions: [
        // Comments Toggle (Mobile)
        if (MediaQuery.of(context).size.width <= 1200)
          IconButton(
            icon: const Icon(Icons.comment),
            onPressed: () => _showCommentsBottomSheet(context),
          ),

        // Share Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FilledButton.icon(
            onPressed: () => _showShareDialog(context),
            icon: const Icon(Icons.lock_open, size: 18),
            label: const Text('Share'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ),

        // Profile
        IconButton(
          icon: const CircleAvatar(radius: 14, child: Text('U')),
          onPressed: () {},
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildRightSidebar() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Comments'),
              Tab(text: 'Activity'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [_buildCommentsTab(), _buildActivityTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 0, // TODO: Load comments
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(radius: 16, child: Text('A')),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '2 hours ago',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
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
                const SizedBox(height: 8),
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
      child: Text(
        'Activity feed coming soon',
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
 Widget _buildCollaboratorAvatars(List<Presence> presences) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, bottom: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...presences.take(3).map((p) => 
            Container(
              margin: const EdgeInsets.only(left: 4),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Color(int.parse(p.color.replaceFirst('#', '0xff'))),
                child: Text(
                  p.name.substring(0, 1),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          if (presences.length > 3)
            Container(
              margin: const EdgeInsets.only(left: 4),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade200,
                child: Text('+${presences.length - 3}'),
              ),
            ),
        ],
      ),
    );
  }
  
  void _showRenameDialog(BuildContext context, DocumentModel doc) {
    final controller = TextEditingController(text: doc.title);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Document title'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(documentControllerProvider(widget.documentId).notifier)
                  .updateTitle(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        expand: false,
        builder: (_, controller) => _buildCommentsTab(),
      ),
    );
  }
}