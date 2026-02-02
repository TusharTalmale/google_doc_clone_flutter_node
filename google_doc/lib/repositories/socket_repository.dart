import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:google_doc/utils/api_constant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_doc/services/socket_client.dart';
import 'package:google_doc/models/presence_model.dart';
import 'package:google_doc/models/socket_events.dart';

part 'socket_repository.g.dart';

@Riverpod(keepAlive: true)

SocketRepository socketRepository(Ref ref) {
  final client = ref.read(socketClientProvider.notifier);
  return SocketRepository(client);
}

class SocketRepository {
  final SocketClient _client;
  final _eventController = StreamController<SocketEvent>.broadcast();
  
  Stream<SocketEvent> get eventStream => _eventController.stream;

  SocketRepository(this._client) {
    _setupEventListeners();
  }

  void _setupEventListeners() {
    _client.on(SocketEvents.documentState, (data) {
      _eventController.add(SocketEvent.documentState(base64State: data as String));
    });

    _client.on(SocketEvents.yjsUpdate, (data) {
      if (data is String) {
        _eventController.add(SocketEvent.yjsUpdate(update: data));
      }
    });

    _client.on(SocketEvents.presenceUpdate, (data) {
      if (data is List) {
        final users = data.map((e) => Presence.fromJson(e as Map<String, dynamic>)).toList();
        _eventController.add(SocketEvent.presenceUpdate(users: users));
      }
    });

    _client.on(SocketEvents.cursorMove, (data) {
      if (data is Map) {
        final cursorData = data['cursor'] as Map<String, dynamic>;
        _eventController.add(SocketEvent.cursorUpdate(
          userId: data['userId'] as String,
          cursor: Cursor.fromJson(cursorData),
        ));
      }
    });

    _client.on(SocketEvents.saveStatus, (data) {
      if (data is Map) {
        _eventController.add(SocketEvent.saveStatus(
          status: data['status'] as String,
          lastSavedAt: data['lastSavedAt'] != null 
              ? DateTime.parse(data['lastSavedAt'] as String)
              : null,
        ));
      }
    });

    _client.on(SocketEvents.newComment, (data) {
      _eventController.add(SocketEvent.newComment(comment: data as Map<String, dynamic>));
    });

    _client.on('error', (data) {
      if (data is Map) {
        _eventController.add(SocketEvent.error(message: data['message'] as String? ?? 'Unknown error'));
      }
    });
  }

  void joinDocument(String documentId) {
    _client.emit(SocketEvents.joinDocument, documentId);
  }

  void sendYjsUpdate(String documentId, Uint8List update) {
    final base64Update = base64Encode(update);
    _client.emit(SocketEvents.yjsUpdate, {
      'documentId': documentId,
      'update': base64Update,
    });
  }

  void sendAwareness(String documentId, Map<String, dynamic> awareness) {
    _client.emit(SocketEvents.awarenessUpdate, {
      'documentId': documentId,
      'awareness': awareness,
    });
  }

  void updateCursor(String documentId, int index, int length) {
    _client.emit(SocketEvents.cursorMove, {
      'documentId': documentId,
      'cursor': {'index': index, 'length': length},
    });
  }

  void updateSelection(String documentId, int index, int length) {
    _client.emit(SocketEvents.selectionChange, {
      'documentId': documentId,
      'range': {'index': index, 'length': length},
    });
  }

  void typingStart(String documentId) {
    _client.emit(SocketEvents.typingStart, documentId);
  }

  void typingStop(String documentId) {
    _client.emit(SocketEvents.typingStop, documentId);
  }

  void disconnect() {
    _eventController.close();
  }
}