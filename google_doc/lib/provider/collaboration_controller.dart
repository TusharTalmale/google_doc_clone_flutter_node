import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_doc/provider/connection_state_provider.dart';
import 'package:google_doc/utils/json_converters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_doc/models/presence_model.dart';
import 'package:google_doc/models/socket_events.dart';
import 'package:google_doc/repositories/socket_repository.dart';
import 'package:google_doc/services/socket_client.dart';
import 'package:google_doc/services/offline_sync_service.dart';

part 'collaboration_controller.g.dart';
part 'collaboration_controller.freezed.dart';

@freezed
abstract class CollaborationState with _$CollaborationState {
  const factory CollaborationState({
    @Default([]) List<Presence> presences,
    @Default('saved') String saveStatus,
    @TimestampConverter() DateTime? lastSavedAt,
    String? errorMessage,
    @Default(false) bool isSyncing,
  }) = _CollaborationState;
}

@riverpod
class CollaborationController extends _$CollaborationController {
  StreamSubscription<SocketEvent>? _sub;
  
  @override
  CollaborationState build(String documentId) {
    _init();
    ref.onDispose(() {
      _sub?.cancel();
      ref.read(socketRepositoryProvider).disconnect();
    });
    return const CollaborationState();
  }

  void _init() {
    // Connect socket if not connected
    final connState = ref.read(socketClientProvider);
    if (connState.asData?.value != SocketConnectionState.connected) {
      ref.read(socketClientProvider.notifier).connect();
    }

    // Join document when connected
    final repo = ref.read(socketRepositoryProvider);
    repo.joinDocument(documentId);

    // Listen to events
    _sub = repo.eventStream.listen((event) {
      event.when(
        documentState: (state) {
          // Handle initial Yjs state - decode base64 and apply to editor
          // This will be handled by the editor widget
        },
        yjsUpdate: (update) {
          // Forward to Quill via event bus or separate provider
          // For now, just log
          if (kDebugMode) print('Received Yjs update');
        },
        presenceUpdate: (users) {
          state = state.copyWith(presences: users);
        },
        cursorUpdate: (userId, cursor) {
          _updateUserCursor(userId, cursor);
        },
        selectionUpdate: (userId, name, color, range) {
          _updateUserSelection(userId, range);
        },
        saveStatus: (status, lastSavedAt) {
          state = state.copyWith(
            saveStatus: status,
            lastSavedAt: lastSavedAt,
          );
        },
        error: (message) {
          state = state.copyWith(errorMessage: message);
        },
        newComment: (comment) {
          // Handle new comment - could refresh comments list
        },
      );
    });
  }

  void _updateUserCursor(String userId, Cursor cursor) {
    final updated = state.presences.map((p) {
      if (p.userId == userId) return p.copyWith(cursor: cursor);
      return p;
    }).toList();
    state = state.copyWith(presences: updated);
  }

  void _updateUserSelection(String userId, Selection selection) {
    final updated = state.presences.map((p) {
      if (p.userId == userId) return p.copyWith(selection: selection);
      return p;
    }).toList();
    state = state.copyWith(presences: updated);
  }

  Future<void> sendCursorUpdate(int index, int length) async {
    final isOnline = ref.read(isOnlineProvider);
    
    if (!isOnline) {
      await ref.read(offlineSyncServiceProvider.notifier).queueOperation(
        type: 'cursor_move',
        documentId: documentId,
        payload: {'cursor': {'index': index, 'length': length}},
      );
      return;
    }
    
    ref.read(socketRepositoryProvider).updateCursor(documentId, index, length);
  }

  Future<void> sendYjsUpdate(String base64Update) async {
    final isOnline = ref.read(isOnlineProvider);
    
    if (!isOnline) {
      await ref.read(offlineSyncServiceProvider.notifier).queueOperation(
        type: 'yjs_update',
        documentId: documentId,
        payload: {'update': base64Update},
      );
      return;
    }
    
    ref.read(socketRepositoryProvider).sendYjsUpdate(
      documentId, 
      base64Decode(base64Update),
    );
  }

  void setTyping(bool isTyping) {
    if (isTyping) {
      ref.read(socketRepositoryProvider).typingStart(documentId);
    } else {
      ref.read(socketRepositoryProvider).typingStop(documentId);
    }
  }
}