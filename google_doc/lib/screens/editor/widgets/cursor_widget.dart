import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_doc/models/presence_model.dart';

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

class _RemoteCursorWidgetState extends State<RemoteCursorWidget> {
  Offset? _position;
  
  @override
  void initState() {
    super.initState();
    _updatePosition();
    widget.controller.addListener(_updatePosition);
  }
  
  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    if (_position == null) return const SizedBox();
    
    return Positioned(
      left: _position!.dx,
      top: _position!.dy,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 2,
            height: 20,
            color: Color(int.parse(widget.presence.color.replaceFirst('#', '0xff'))),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Color(int.parse(widget.presence.color.replaceFirst('#', '0xff'))),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              widget.presence.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}