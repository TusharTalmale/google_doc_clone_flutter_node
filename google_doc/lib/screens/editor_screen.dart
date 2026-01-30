// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:flutter_quill/quill_delta.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_doc/services/socket_client.dart';

// class DocumentEditorScreen extends ConsumerStatefulWidget {
//   final String documentId;

//   const DocumentEditorScreen({super.key, required this.documentId});

//   @override
//   ConsumerState<DocumentEditorScreen> createState() =>
//       _DocumentEditorScreenState();
// }

// class _DocumentEditorScreenState extends ConsumerState<DocumentEditorScreen> {
//   QuillController? _controller;
//   final FocusNode _focusNode = FocusNode();
//   Timer? _autoSaveTimer;

//   @override
//   void initState() {
//     super.initState();
//     _setupEditor();
//   }

//   void _setupEditor() {
//     // 1. Initialize Controller
//     // Note: In a real app, fetch the initial document content (Delta) via REST API first,
//     // then initialize: QuillController(document: Document.fromDelta(initialDelta), ...)
//     _controller = QuillController.basic();

//     // 2. Connect Socket
//     final socketService = ref.read(socketServiceProvider);
//     socketService.connect();
//     socketService.joinDocument(widget.documentId);

//     // 3. Listen to Local Changes -> Send to Socket
//     _controller!.document.changes.listen((event) {
//       // Only emit changes triggered by the user (ChangeSource.local)
//       if (event.source == ChangeSource.local) {
//         final delta = event.change.toJson();
//         socketService.sendChanges(widget.documentId, delta);

//         // Optional: Trigger auto-save throttling
//         _triggerAutoSave();
//       }
//     });

//     // 4. Listen to Remote Changes -> Apply to Editor
//     socketService.onReceiveChanges((data) {
//       if (data != null) {
//         // 'data' is the Delta JSON list from the server
//         final delta = Delta.fromJson(data);

//         // Apply change with ChangeSource.remote to prevent echo loops
//         _controller!.compose(
//           delta,
//           _controller!.selection,
//           ChangeSource.remote,
//         );
//       }
//     });
//   }

//   void _triggerAutoSave() {
//     _autoSaveTimer?.cancel();
//     _autoSaveTimer = Timer(const Duration(seconds: 2), () {
//       final content = _controller!.document.toDelta().toJson();
//       ref.read(socketServiceProvider).saveDocument(widget.documentId, content);
//     });
//   }

//   @override
//   void dispose() {
//     _autoSaveTimer?.cancel();
//     _controller?.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_controller == null) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text('Document Editor')),
//       body: Column(
//         children: [
//           QuillSimpleToolbar(
//             controller: _controller!,
//           ),
//           Expanded(
//             child: QuillEditor.basic(
//               controller: _controller!,
//               focusNode: _focusNode,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
