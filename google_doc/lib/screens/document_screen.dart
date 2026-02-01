import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/services/socket_client.dart'; // Ensure this path is correct

// --- THEME CONSTANTS ---
const kDocsGrey = Color(0xfff9fbfd);
const kDocsToolbarColor = Color(0xffedf2fa);
const kDocsSelectedBlue = Colors.blue;
const kDocsBorderColor = Color(0xffdadce0);

// =============================================================================
// MAIN SCREEN
// =============================================================================

class DocumentScreen extends ConsumerStatefulWidget {
  final String documentId;
  const DocumentScreen({super.key, required this.documentId});

  @override
  ConsumerState<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  QuillController? _controller;
  final FocusNode _focusNode = FocusNode();
  Timer? _autoSaveTimer;

  bool _showOutline = true;
  bool _showRightPanel = false;

  @override
  void initState() {
    super.initState();
    _setupEditor();
  }

  void _setupEditor() {
    _controller = QuillController.basic();
    final socketService = ref.read(socketServiceProvider);

    if (!socketService.isConnected) socketService.connect();
    socketService.joinDocument(widget.documentId);

    _controller!.document.changes.listen((event) {
      if (event.source == ChangeSource.local) {
        final delta = event.change.toJson();
        socketService.sendChanges(widget.documentId, delta);
        _triggerAutoSave();
      }
    });

    socketService.onReceiveChanges((data) {
      if (data != null && mounted) {
        final delta = Delta.fromJson(data);
        _controller!.compose(
          delta,
          _controller!.selection,
          ChangeSource.remote,
        );
      }
    });
  }

  void _triggerAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer(const Duration(seconds: 2), () {
      final content = _controller!.document.toDelta().toJson();
      ref.read()(widget.documentId, content);
    });
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _controller?.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;

    return Scaffold(
      backgroundColor: kDocsGrey,
      appBar: _DocAppBar(
        isMobile: isMobile,
        onPrint: () => _showPrintPreview(context),
      ),
      endDrawer: isMobile ? const Drawer(child: _RightPanel()) : null,
      body: Column(
        children: [
          _MainToolbar(
            controller: _controller!,
            outlineActive: _showOutline,
            detailsActive: _showRightPanel,
            onToggleOutline: () => setState(() => _showOutline = !_showOutline),
            onToggleDetails: () =>
                setState(() => _showRightPanel = !_showRightPanel),
          ),
          if (!isMobile) const MarginRuler(),
          Expanded(
            child: Row(
              children: [
                if (_showOutline && !isMobile) const HeadingNavigator(),
                Expanded(
                  child: _EditorSurface(
                    controller: _controller!,
                    focusNode: _focusNode,
                    isMobile: isMobile,
                  ),
                ),
                if (_showRightPanel && !isMobile)
                  const SizedBox(width: 300, child: _RightPanel()),
              ],
            ),
          ),
          const _BottomZoomBar(),
        ],
      ),
    );
  }

  void _showPrintPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _PrintPreviewDialog(controller: _controller!),
    );
  }
}

// =============================================================================
// UI COMPONENTS
// =============================================================================

class _DocAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isMobile;
  final VoidCallback onPrint;

  const _DocAppBar({required this.isMobile, required this.onPrint});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: kDocsBorderColor, height: 1),
      ),
      title: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.description, color: Colors.blue, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Untitled document",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (!isMobile)
                  Row(
                    children:
                        ["File", "Edit", "View", "Insert", "Format", "Tools"]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(
                                  right: 14,
                                  top: 2,
                                ),
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.history, color: Colors.black54),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.comment_outlined, color: Colors.black54),
          onPressed: () {},
        ),
        if (!isMobile) const _Collaborators(),
        const SizedBox(width: 12),
        const _ShareButton(),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(68);
}

class _MainToolbar extends StatelessWidget {
  final QuillController controller;
  final bool outlineActive;
  final bool detailsActive;
  final VoidCallback onToggleOutline;
  final VoidCallback onToggleDetails;

  const _MainToolbar({
    required this.controller,
    required this.outlineActive,
    required this.detailsActive,
    required this.onToggleOutline,
    required this.onToggleDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: kDocsToolbarColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: outlineActive ? kDocsSelectedBlue : Colors.black54,
            ),
            onPressed: onToggleOutline,
            tooltip: "Outline",
          ),
          const VerticalDivider(width: 20, indent: 8, endIndent: 8),
          Expanded(
            child: SizedBox(
              height: 42 ,
              child: QuillSimpleToolbar(
                controller: controller,
config: QuillSimpleToolbarConfig(
  showFontFamily: false,
  showFontSize: false,
  multiRowsDisplay: false,
  showDividers: true,
),
                
              ),
            ),
          ),
          const VerticalDivider(width: 20, indent: 8, endIndent: 8),
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: detailsActive ? kDocsSelectedBlue : Colors.black54,
            ),
            onPressed: onToggleDetails,
            tooltip: "Details",
          ),
        ],
      ),
    );
  }
}

class _EditorSurface extends StatelessWidget {
  final QuillController controller;
  final FocusNode focusNode;
  final bool isMobile;

  const _EditorSurface({
    required this.controller,
    required this.focusNode,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: isMobile ? double.infinity : 816,
          margin: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: isMobile ? 8 : 16,
          ),
          padding: EdgeInsets.all(isMobile ? 24 : 56),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: kDocsBorderColor),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              QuillEditor(
                controller: controller,
                focusNode: focusNode,
                scrollController: ScrollController(),
          
                config :QuillEditorConfig(
                  placeholder: "Type @ to insert",
                  scrollable: false,

                )
                  
              ),
              const Positioned(
                left: 300,
                top: 200,
                child: RemoteCursor(name: "Rahul", color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// MARGINS & NAVIGATORS
// =============================================================================

class MarginRuler extends StatelessWidget {
  const MarginRuler({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: const BoxDecoration(
        color: Color(0xfff8f9fa),
        border: Border(bottom: BorderSide(color: kDocsBorderColor)),
      ),
      child: Stack(
        children: [
          Row(
            children: List.generate(
              60,
              (index) => Expanded(
                child: Center(
                  child: Container(
                    width: 1,
                    height: index % 5 == 0 ? 12 : 6,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            left: 100,
            top: 0,
            child: _MarginHandle(isLeft: true),
          ),
          const Positioned(
            right: 100,
            top: 0,
            child: _MarginHandle(isLeft: false),
          ),
        ],
      ),
    );
  }
}

class _MarginHandle extends StatelessWidget {
  final bool isLeft;
  const _MarginHandle({required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.arrow_drop_down, size: 20, color: kDocsSelectedBlue),
        Container(width: 2, height: 10, color: kDocsSelectedBlue),
      ],
    );
  }
}

class HeadingNavigator extends StatelessWidget {
  const HeadingNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: kDocsBorderColor)),
      ),
      child: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Document outline",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          _HeadingTile(title: "Introduction", level: 1),
          _HeadingTile(title: "Getting Started", level: 2),
          _HeadingTile(title: "Conclusion", level: 1),
        ],
      ),
    );
  }
}

class _HeadingTile extends StatelessWidget {
  final String title;
  final int level;
  const _HeadingTile({required this.title, required this.level});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0 * level,
          top: 10,
          bottom: 10,
          right: 8,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: level == 1 ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SMALL UI ELEMENTS
// =============================================================================

class RemoteCursor extends StatelessWidget {
  final String name;
  final Color color;
  const RemoteCursor({super.key, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            name,
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        Container(width: 2, height: 20, color: color),
      ],
    );
  }
}

class _RightPanel extends StatelessWidget {
  const _RightPanel();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: const [
          ListTile(leading: Icon(Icons.settings), title: Text("Page setup")),
          ListTile(leading: Icon(Icons.history), title: Text("Activity")),
          ListTile(leading: Icon(Icons.palette), title: Text("Format options")),
        ],
      ),
    );
  }
}

class _Collaborators extends StatelessWidget {
  const _Collaborators();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        CircleAvatar(
          radius: 14,
          backgroundColor: Colors.orange,
          child: Text("A", style: TextStyle(fontSize: 12)),
        ),
        SizedBox(width: 4),
        CircleAvatar(
          radius: 14,
          backgroundColor: Colors.green,
          child: Text("R", style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffc2e7ff),
        foregroundColor: const Color(0xff001d35),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      icon: const Icon(Icons.lock_outline, size: 18),
      label: const Text("Share"),
    );
  }
}

class _BottomZoomBar extends StatelessWidget {
  const _BottomZoomBar();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: kDocsBorderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(Icons.zoom_out, size: 14),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text("100%", style: TextStyle(fontSize: 12)),
          ),
          Icon(Icons.zoom_in, size: 14),
        ],
      ),
    );
  }
}

class _PrintPreviewDialog extends StatelessWidget {
  final QuillController controller;
  const _PrintPreviewDialog({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(title: const Text("Print Preview")),
        backgroundColor: const Color(0xff525659),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Container(
              width: 816,
              height: 1056,
              color: Colors.white,
              padding: const EdgeInsets.all(56),
              child: QuillEditor(
                controller: controller,
                focusNode: FocusNode(),
                scrollController: ScrollController(),
                config: QuillEditorConfig(
                  showCursor: true,
                  checkBoxReadOnly: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
