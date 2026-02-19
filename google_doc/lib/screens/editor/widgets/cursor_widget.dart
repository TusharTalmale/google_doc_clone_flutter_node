import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_doc/models/presence_model.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';

/// Displays a remote user's cursor position overlaid on the QuillEditor.
///
/// It uses the [editorKey] to find the QuillEditor's RenderEditor and
/// convert a document offset (from [presence.cursor.index]) into pixel
/// coordinates within the Stack.
class RemoteCursorWidget extends StatefulWidget {
  final Presence presence;
  final QuillController controller;
  final GlobalKey editorKey;

  const RemoteCursorWidget({
    super.key,
    required this.presence,
    required this.controller,
    required this.editorKey,
  });

  @override
  State<RemoteCursorWidget> createState() => _RemoteCursorWidgetState();
}

class _RemoteCursorWidgetState extends State<RemoteCursorWidget>
    with SingleTickerProviderStateMixin {
  Offset? _cursorOffset;
  double _lineHeight = 22.0;
  late AnimationController _blinkController;
  Timer? _hideTimer;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    // Recalculate whenever the local document changes (e.g. remote insert
    // shifts positions).
    widget.controller.addListener(_scheduleUpdate);
    _scheduleUpdate();
  }

  @override
  void didUpdateWidget(covariant RemoteCursorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.presence.cursor != widget.presence.cursor) {
      _resetHideTimer();
      _scheduleUpdate();
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_scheduleUpdate);
      widget.controller.addListener(_scheduleUpdate);
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _blinkController.dispose();
    widget.controller.removeListener(_scheduleUpdate);
    super.dispose();
  }

  void _resetHideTimer() {
    _hideTimer?.cancel();
    if (!_visible) {
      setState(() => _visible = true);
    }
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _visible = false);
    });
  }

  void _scheduleUpdate() {
    // Post-frame because the RenderEditor may not have laid out yet after
    // a document change.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _calculatePosition();
    });
  }

  /// Walk the QuillEditor's render tree to find the RenderEditor, then
  /// ask it for the pixel offset of the remote cursor index.
  void _calculatePosition() {
    final cursor = widget.presence.cursor;
    if (cursor == null) return;

    final editorContext = widget.editorKey.currentContext;
    if (editorContext == null) return;

    // Find the RenderEditor inside the QuillEditor widget tree.
    RenderBox? renderEditor;
    editorContext.visitChildElements((element) {
      _findRenderEditor(element, (found) {
        renderEditor = found;
      });
    });

    // Fallback: use the editorContext's own RenderBox if we can't find
    // a RenderEditor specifically.
    renderEditor ??= editorContext.findRenderObject() as RenderBox?;
    if (renderEditor == null || !renderEditor!.hasSize) return;

    try {
      final docLength = widget.controller.document.length;
      // Clamp cursor index to valid range
      final clampedIndex = cursor.index.clamp(0, docLength - 1);

      final textPosition = TextPosition(offset: clampedIndex);

      // Use getOffsetForCaret to get pixel position
      final caretOffset = _getCaretOffset(renderEditor!, textPosition);
      if (caretOffset == null) return;

      // Convert from RenderEditor local coords to the Stack's local coords
      final stackContext = context;
      final stackRenderBox = stackContext.findRenderObject() as RenderBox?;
      if (stackRenderBox == null) return;

      final globalOffset = renderEditor!.localToGlobal(caretOffset);
      final localOffset = stackRenderBox.globalToLocal(globalOffset);

      if (mounted) {
        setState(() {
          _cursorOffset = localOffset;
        });
      }
    } catch (e) {
      debugPrint('Cursor position error: $e');
    }
  }

  /// Try to get caret offset from a RenderBox. If the RenderBox is a
  /// RenderEditableContainerBox (QuillEditor's internal type) it has
  /// `getOffsetForCaret`. Otherwise we fall back to a simpler estimation.
  Offset? _getCaretOffset(RenderBox box, TextPosition position) {
    // QuillEditor uses RenderEditableContainerBox which extends RenderBox
    // and has getOffsetForCaret.
    try {
      // Use dynamic dispatch to call getOffsetForCaret if it exists
      final dynamic renderObj = box;
      final offset = renderObj.getOffsetForCaret(position) as Offset?;
      if (offset != null) {
        _lineHeight = _getPreferredLineHeight(renderObj) ?? 22.0;
        return offset;
      }
    } catch (_) {
      // getOffsetForCaret not available on this render object
    }

    // Fallback: estimate position based on document structure
    return _estimatePosition(box, position.offset);
  }

  double? _getPreferredLineHeight(dynamic renderObj) {
    try {
      return renderObj.preferredLineHeight as double?;
    } catch (_) {
      return null;
    }
  }

  /// Simple fallback estimation for cursor position when we can't find
  /// getOffsetForCaret. Uses font metrics and document structure.
  Offset? _estimatePosition(RenderBox box, int offset) {
    try {
      final doc = widget.controller.document;
      final docLength = doc.length;
      if (docLength <= 1) return const Offset(48, 48); // padding offset

      // Rough estimation: calculate line number and character offset
      final text = doc.toPlainText();
      final clampedOffset = offset.clamp(0, text.length);
      final before = text.substring(0, clampedOffset);
      final lines = '\n'.allMatches(before).length;
      final lastNewline = before.lastIndexOf('\n');
      final charInLine = clampedOffset - (lastNewline + 1);

      // Approximate: 14px font, 1.6 line height = ~22.4 px per line
      const lineH = 22.4;
      const charW = 8.4; // approximate char width for 14px font
      const padTop = 48.0;
      const padLeft = 48.0;

      return Offset(
        padLeft + charInLine * charW,
        padTop + lines * lineH,
      );
    } catch (_) {
      return null;
    }
  }

  /// Recursively search for a render object that has `getOffsetForCaret`.
  void _findRenderEditor(Element element, void Function(RenderBox) onFound) {
    final renderObject = element.renderObject;
    if (renderObject is RenderBox) {
      // Check if this render object has getOffsetForCaret via duck-typing
      try {
        final dynamic obj = renderObject;
        // ignore: unnecessary_null_comparison
        if (obj.getOffsetForCaret != null) {
          onFound(renderObject);
          return;
        }
      } catch (_) {}
    }
    element.visitChildElements((child) {
      _findRenderEditor(child, onFound);
    });
  }

  Color get _cursorColor {
    try {
      return Color(
          int.parse(widget.presence.color.replaceFirst('#', '0xff')));
    } catch (e) {
      return AppColors.cursorColors[
          widget.presence.name.hashCode.abs() % AppColors.cursorColors.length];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cursorOffset == null || !_visible) return const SizedBox.shrink();

    final color = _cursorColor;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      left: _cursorOffset!.dx,
      top: _cursorOffset!.dy,
      child: IgnorePointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Name label above cursor
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spaceXs,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.85)],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.radiusSm),
                  topRight: Radius.circular(AppSizes.radiusSm),
                  bottomRight: Radius.circular(AppSizes.radiusSm),
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.presence.name.isNotEmpty
                            ? widget.presence.name
                                .substring(0, 1)
                                .toUpperCase()
                            : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.presence.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),

            // Cursor line with blink animation
            FadeTransition(
              opacity: Tween<double>(begin: 0.4, end: 1.0)
                  .animate(_blinkController),
              child: Container(
                width: 2.5,
                height: _lineHeight,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      BorderRadius.circular(AppSizes.radiusXxl),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Selection highlight widget for remote users.
///
/// Draws a translucent rectangle over the text range that a remote user
/// has selected.
class RemoteSelectionWidget extends StatelessWidget {
  final Presence presence;
  final Offset start;
  final Offset end;
  final double height;

  const RemoteSelectionWidget({
    super.key,
    required this.presence,
    required this.start,
    required this.end,
    required this.height,
  });

  Color get _selectionColor {
    try {
      return Color(
              int.parse(presence.color.replaceFirst('#', '0xff')))
          .withOpacity(0.2);
    } catch (e) {
      return AppColors
          .cursorColors[
              presence.name.hashCode.abs() % AppColors.cursorColors.length]
          .withOpacity(0.2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: start.dx,
      top: start.dy,
      child: Container(
        width: (end.dx - start.dx).abs(),
        height: height,
        decoration: BoxDecoration(
          color: _selectionColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}