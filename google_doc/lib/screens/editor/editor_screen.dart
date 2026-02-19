import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/provider/collaboration_controller.dart';
import 'package:google_doc/provider/document_controller.dart';
import 'package:google_doc/screens/editor/widgets/collaborator_avatars.dart';
import 'package:google_doc/screens/editor/widgets/comments_bottom_sheet.dart';
import 'package:google_doc/screens/editor/widgets/cursor_widget.dart';
import 'package:google_doc/screens/editor/widgets/editor_app_bar.dart';
import 'package:google_doc/screens/editor/widgets/editor_right_sidebar.dart';
import 'package:google_doc/screens/editor/widgets/editor_toolbar.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';

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
  final GlobalKey _editorKey = GlobalKey();
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
    _socketChangeSub = ref
        .read(
            collaborationControllerProvider(widget.documentId).notifier)
        .deltaStream
        .listen((delta) {
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
        debugPrint('Error loading document: $e');
      }
    }

    _setupSocketListener();

    // Listen for local changes → send delta + cursor position
    _quillChangeSub?.cancel();
    _quillChangeSub = _quillController.changes.listen((change) {
      if (change.source == ChangeSource.local) {
        // 1. Send real-time delta over socket
        ref
            .read(collaborationControllerProvider(widget.documentId).notifier)
            .sendDelta(change.change.toJson());

        // 2. Send cursor position
        _sendLocalCursor();

        // 3. Schedule auto-save to database
        _autoSave();
      }
    });

    // Also listen for selection changes (tap to reposition cursor, drag selection)
    _quillController.addListener(_sendLocalCursor);
  }

  void _sendLocalCursor() {
    final sel = _quillController.selection;
    ref
        .read(collaborationControllerProvider(widget.documentId).notifier)
        .sendCursorUpdate(sel.baseOffset, sel.extentOffset - sel.baseOffset);
  }

  void _autoSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        final content = _quillController.document.toDelta().toJson();
        ref
            .read(documentControllerProvider(widget.documentId).notifier)
            .saveContent(content);
      }
    });
  }

  void _showCommentsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CommentsBottomSheet(),
    );
  }

  @override
  void dispose() {
    _quillController.removeListener(_sendLocalCursor);
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
    final collabState = ref.watch(
      collaborationControllerProvider(widget.documentId),
    );
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > AppSizes.desktopBreakpoint;

    return Portal(
      child: Scaffold(
        appBar: EditorAppBar(
          documentId: widget.documentId,
          quillController: _quillController,
          onCommentsTap: _showCommentsBottomSheet,
        ),
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
                    EditorToolbar(
                      controller: _quillController,
                      isDark: isDark,
                    ),

                    // Editor + Remote Cursors
                    Expanded(
                      child: Stack(
                        children: [
                          // Paper
                          Center(
                            child: Container(
                              width: AppSizes.editorMaxWidth,
                              margin:
                                  const EdgeInsets.all(AppSizes.spaceLg),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkSurface
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(
                                    AppSizes.radiusSm),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        isDark ? 0.3 : 0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    AppSizes.radiusSm),
                                child: QuillEditor(
                                  key: _editorKey,
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
                                              : AppColors
                                                  .lightTextPrimary,
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
                            if (presence.cursor == null) {
                              return const SizedBox.shrink();
                            }
                            return RemoteCursorWidget(
                              key: ValueKey(
                                  'cursor_${presence.userId}'),
                              presence: presence,
                              controller: _quillController,
                              editorKey: _editorKey,
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Right Sidebar (Comments & Activity)
              if (isDesktop) EditorRightSidebar(isDark: isDark),
            ],
          ),
        ),

        // Floating collaborator avatars
        floatingActionButton: collabState.presences.isEmpty
            ? null
            : CollaboratorAvatars(presences: collabState.presences),
      ),
    );
  }
}