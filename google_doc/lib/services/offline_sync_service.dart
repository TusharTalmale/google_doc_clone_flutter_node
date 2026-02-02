import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_doc/services/dio_client.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_doc/services/socket_client.dart';
import 'package:google_doc/utils/api_constant.dart';
import 'package:google_doc/provider/connection_state_provider.dart';

part 'offline_sync_service.g.dart';

@HiveType(typeId: 1)
class PendingOperation extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String documentId;

  @HiveField(3)
  final String payload;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  int retryCount;

  @HiveField(6)
  DateTime? lastAttempt;

  PendingOperation({
    required this.id,
    required this.type,
    required this.documentId,
    required this.payload,
    required this.createdAt,
    this.retryCount = 0,
    this.lastAttempt,
  });
}

class PendingOperationAdapter extends TypeAdapter<PendingOperation> {
  @override
  final int typeId = 1;

  @override
  PendingOperation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingOperation(
      id: fields[0] as String,
      type: fields[1] as String,
      documentId: fields[2] as String,
      payload: fields[3] as String,
      createdAt: fields[4] as DateTime,
      retryCount: fields[5] as int,
      lastAttempt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PendingOperation obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.documentId)
      ..writeByte(3)
      ..write(obj.payload)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.retryCount)
      ..writeByte(6)
      ..write(obj.lastAttempt);
  }
}

@Riverpod(keepAlive: true)
class OfflineSyncService extends _$OfflineSyncService {
  Box<PendingOperation>? _queueBox;

  @override
  Future<void> build() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(PendingOperationAdapter());
    }

    _queueBox = await Hive.openBox<PendingOperation>('sync_queue');

    ref.listen<bool>(isOnlineProvider, (prev, next) {
      if (next) {
        _syncPendingOperations();
      }
    });
  }

  Future<void> queueOperation({
    required String type,
    required String documentId,
    required Map<String, dynamic> payload,
  }) async {
    // Ensure initialization is complete
    if (_queueBox == null) await future;

    final operation = PendingOperation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      documentId: documentId,
      payload: jsonEncode(payload),
      createdAt: DateTime.now(),
    );
    await _queueBox!.put(operation.id, operation);

    // Try to sync immediately if connected
    final result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      _syncPendingOperations();
    }
  }

  Future<void> _syncPendingOperations() async {
    if (_queueBox == null) return;

    final now = DateTime.now();
    final pending = _queueBox!.values.where((op) {
      if (op.retryCount >= 5) return false; // Max retries cap

      // Exponential backoff: 2^retryCount seconds (2s, 4s, 8s, 16s...)
      if (op.lastAttempt != null) {
        final backoff = Duration(seconds: pow(2, op.retryCount).toInt());
        if (now.difference(op.lastAttempt!) < backoff) return false;
      }
      return true;
    }).toList();

    if (pending.isEmpty) return;

    final socket = ref.read(socketClientProvider.notifier);
    if (!socket.isConnected) {
      final completer = Completer<void>();
      final sub = ref.listen<AsyncValue<SocketConnectionState>>(
        socketClientProvider,
        (_, next) {
          if (next.asData?.value == SocketConnectionState.connected &&
              !completer.isCompleted) {
            completer.complete();
          }
        },
      );
      socket.connect();

      try {
        await completer.future.timeout(const Duration(seconds: 10));
      } catch (_) {
        sub.close();
        return;
      }
      sub.close();
    }

    for (final op in pending) {
      try {
        await _executeOperation(op);
        await op.delete();
      } catch (e) {
        op.retryCount++;
        op.lastAttempt = DateTime.now();
        await op.save();
      }
    }
  }

  Future<void> _executeOperation(PendingOperation op) async {
    final payload = jsonDecode(op.payload) as Map<String, dynamic>;

    switch (op.type) {
      case 'yjs_update':
        ref.read(socketClientProvider.notifier).emit('yjs-update', {
          'documentId': op.documentId,
          'update': payload['update'],
        });
        break;
      case 'cursor_move':
        ref.read(socketClientProvider.notifier).emit('cursor-move', {
          'documentId': op.documentId,
          'cursor': payload['cursor'],
        });
        break;
      case 'save_document':
        // Use HTTP API for saves
        final dio = ref.read(dioClientProvider);
        await dio.post(
          '${ApiConstants.saveDocument}/${op.documentId}',
          data: {'content': payload['content']},
        );
        break;
    }
  }

  bool get hasPendingSync => _queueBox?.isNotEmpty ?? false;

  List<PendingOperation> getPendingForDocument(String docId) {
    return _queueBox?.values.where((op) => op.documentId == docId).toList() ??
        [];
  }
}
