import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_doc/models/presence_model.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';

class RemoteCursorWidget extends StatefulWidget {
  final Presence presence;
  final QuillController controller;
  
  const RemoteCursorWidget({
    super.key,
    required this.presence,
    required this.controller,
  });

  @override
  State<RemoteCursorWidget> createState() => _RemoteCursorWidgetState();
}

class _RemoteCursorWidgetState extends State<RemoteCursorWidget> 
    with SingleTickerProviderStateMixin {
  Offset? _position;
  late AnimationController _blinkController;
  
  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _updatePosition();
    widget.controller.addListener(_updatePosition);
  }
  
  @override
  void dispose() {
    _blinkController.dispose();
    widget.controller.removeListener(_updatePosition);
    super.dispose();
  }
  
  void _updatePosition() {
    // Calculate position from cursor index
    // This is a simplified version - real implementation needs render box calculations
    setState(() {
      // _position = calculate offset from widget.presence.cursor?.index
    });
  }

  Color get _cursorColor {
    try {
      return Color(int.parse(widget.presence.color.replaceFirst('#', '0xff')));
    } catch (e) {
      // Fallback to a color from our cursor palette
      return AppColors.cursorColors[widget.presence.name.hashCode.abs() % AppColors.cursorColors.length];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_position == null) return const SizedBox();
    
    final color = _cursorColor;
    
    return Positioned(
      left: _position!.dx,
      top: _position!.dy,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cursor line with blink animation
          FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(_blinkController),
            child: Container(
              width: 2.5,
              height: 22,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppSizes.radiusXxl),
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
          const SizedBox(height: 2),
          // Name label with gradient background
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spaceXs,
              vertical: AppSizes.spaceXxs,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      widget.presence.name.isNotEmpty 
                          ? widget.presence.name.substring(0, 1).toUpperCase()
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
        ],
      ),
    );
  }
}

/// Selection highlight widget for remote users
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
      return Color(int.parse(presence.color.replaceFirst('#', '0xff'))).withOpacity(0.2);
    } catch (e) {
      return AppColors.cursorColors[presence.name.hashCode.abs() % AppColors.cursorColors.length].withOpacity(0.2);
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