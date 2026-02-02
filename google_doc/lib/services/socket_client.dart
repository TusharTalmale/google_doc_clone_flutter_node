import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:google_doc/utils/api_constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_doc/services/storage_service.dart';
import 'package:google_doc/provider/connection_state_provider.dart';

part 'socket_client.g.dart';

enum SocketConnectionState {
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
}

@Riverpod(keepAlive: true)
class SocketClient extends _$SocketClient {
  io.Socket? _socket;
  final _connectionController =
      StreamController<SocketConnectionState>.broadcast();
  final _eventController = StreamController<Map<String, dynamic>>.broadcast();

  // Queue for events when offline
  final List<Map<String, dynamic>> _offlineQueue = [];

  @override
  Stream<SocketConnectionState> build() {
    _connectionController.add(SocketConnectionState.disconnected);

    ref.listen<bool>(isOnlineProvider, (prev, next) {
      if (next && !isConnected) {
        connect();
      }
    });

    ref.onDispose(() {
      _connectionController.close();
      _eventController.close();
      disconnect();
    });
    return _connectionController.stream;
  }

  Future<void> connect() async {
    if (_socket?.connected == true) return;

    final token = await ref.read(storageServiceProvider).getToken();
    if (token == null) {
      _connectionController.add(SocketConnectionState.error);
      return;
    }

    _connectionController.add(SocketConnectionState.connecting);

    _socket = io.io(
      ApiConstants.baseUrl,
      io.OptionBuilder()
          .setTransports([
            'polling',
            'websocket',
          ]) // <-- PUT POLLING FIRST for web
          .disableAutoConnect()
          .enableReconnection()
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .setRandomizationFactor(0.5)
          .setAuth({'token': token})
          .setExtraHeaders({'Authorization': 'Bearer $token'}) // <-- ADD THIS
          .build(),
    );

    _setupListeners();
    _socket!.connect();
  }

  void _setupListeners() {
    _socket!.onConnect((_) {
      debugPrint('✅ Socket connected: ${_socket!.id}');
      _connectionController.add(SocketConnectionState.connected);
      _flushOfflineQueue();
    });

    _socket!.onDisconnect((_) {
      debugPrint('❌ Socket disconnected');
      _connectionController.add(SocketConnectionState.disconnected);
    });

    _socket!.onReconnectAttempt((attempt) {
      debugPrint('🔄 Reconnect attempt: $attempt');
      _connectionController.add(SocketConnectionState.reconnecting);
    });

    _socket!.onConnectError((error) {
      debugPrint('⚠️ Socket error: $error');
      _connectionController.add(SocketConnectionState.error);
    });

    // Generic event handler - specific handlers will listen to _eventController
    _socket!.onAny((event, data) {
      _eventController.add({'event': event, 'data': data});
    });
  }

  void emit(String event, dynamic data) {
    final payload = {
      'event': event,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    };

    if (_socket?.connected == true) {
      _socket!.emit(event, data);
    } else {
      // Queue if important, or discard if not
      _offlineQueue.add(payload);
    }
  }

  void on(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }

  void off(String event) {
    _socket?.off(event);
  }

  void _flushOfflineQueue() {
    if (_offlineQueue.isEmpty) return;

    debugPrint('📤 Flushing ${_offlineQueue.length} offline events');
    for (final payload in _offlineQueue) {
      _socket?.emit(payload['event'], payload['data']);
    }
    _offlineQueue.clear();
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }

  bool get isConnected => _socket?.connected ?? false;

  Stream<Map<String, dynamic>> get eventStream => _eventController.stream;
}
