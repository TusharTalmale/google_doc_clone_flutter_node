import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:google_doc/utils/constant/api_constant.dart';
import 'package:google_doc/utils/constant/socket_events.dart';
import 'package:google_doc/services/storage_service.dart';

final socketServiceProvider = Provider<SocketService>((ref) {
  final service = SocketService(ref);

  ref.onDispose(() {
    service.disconnect();
  });

  return service;
});

class SocketService {
  final Ref _ref;
  io.Socket? _socket;

  SocketService(this._ref);

  bool get isConnected => _socket?.connected ?? false;

  // ===========================================================================
  // CONNECT
  // ===========================================================================
  Future<void> connect() async {
    final token = await _ref.read(storageServiceProvider).getToken();

    if (token == null) return;

    // already connected → do nothing
    if (_socket != null && _socket!.connected) return;

    _socket = io.io(
      ApiConstants.baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableReconnection() // ✅ auto reconnect
          .setReconnectionAttempts(999)
          .setReconnectionDelay(1000)
          .setAuth({'token': token})
          .build(),
    );

    _socket!.connect();

    _socket!.onConnect((_) {
      print('✅ Socket connected: ${_socket!.id}');
    });

    _socket!.onDisconnect((_) {
      print('❌ Socket disconnected');
    });

    _socket!.onConnectError((e) {
      print('⚠️ Socket connect error: $e');
    });
  }

  // ===========================================================================
  // CLIENT → SERVER
  // ===========================================================================

  void joinDocument(String documentId) {
    _emit(SocketEvents.joinDocument, documentId);
  }

  void sendChanges(String documentId, dynamic delta) {
    _emit(SocketEvents.sendChanges, {
      'documentId': documentId,
      'delta': delta,
    });
  }

  void updateCursor(String documentId, int index, int length, String userName) {
    _emit(SocketEvents.cursorMove, {
      'documentId': documentId,
      'cursor': {
        'index': index,
        'length': length,
        'name': userName,
      }
    });
  }

  void saveDocument(String documentId, dynamic content) {
    _emit(SocketEvents.saveDocument, {
      'documentId': documentId,
      'content': content,
    });
  }

  void typingStart(String documentId) {
    _emit(SocketEvents.typingStart, documentId);
  }

  void typingStop(String documentId) {
    _emit(SocketEvents.typingStop, documentId);
  }

  // ===========================================================================
  // SERVER → CLIENT
  // ===========================================================================

  void onReceiveChanges(void Function(dynamic) callback) {
    _on(SocketEvents.receiveChanges, callback);
  }

  void onPresenceUpdate(void Function(List<dynamic>) callback) {
    _on(SocketEvents.presenceUpdate, (data) {
      callback(List<dynamic>.from(data));
    });
  }

  void onSaveStatus(void Function(Map<String, dynamic>) callback) {
    _on(SocketEvents.saveStatus, (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  // ===========================================================================
  // INTERNAL HELPERS
  // ===========================================================================

  void _emit(String event, dynamic data) {
    if (_socket?.connected == true) {
      _socket!.emit(event, data);
    }
  }

  void _on(String event, Function(dynamic) callback) {

    _socket?.off(event);
    _socket?.on(event, callback);
  }

  // ===========================================================================
  // CLEANUP
  // ===========================================================================

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}
