import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_doc/models/presence_model.dart';

part 'socket_events.freezed.dart';


@freezed
class SocketEvent with _$SocketEvent {
  const factory SocketEvent.documentState({
    required String base64State,
  }) = DocumentStateEvent;

  const factory SocketEvent.yjsUpdate({
    required String update,
  }) = YjsUpdateEvent;

  const factory SocketEvent.presenceUpdate({
    required List<Presence> users,
  }) = PresenceUpdateEvent;

  const factory SocketEvent.cursorUpdate({
    required String userId,
    required Cursor cursor,
  }) = CursorUpdateEvent;

  const factory SocketEvent.selectionUpdate({
    required String userId,
    required String name,
    required String color,
    required Selection range,
  }) = SelectionUpdateEvent;

  const factory SocketEvent.saveStatus({
    required String status,
    DateTime? lastSavedAt,
  }) = SaveStatusEvent;

  const factory SocketEvent.error({
    required String message,
  }) = ErrorEvent;

  const factory SocketEvent.newComment({
    required Map<String, dynamic> comment,
  }) = NewCommentEvent;
}