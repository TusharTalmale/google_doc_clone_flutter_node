import 'package:freezed_annotation/freezed_annotation.dart';

part 'presence_model.freezed.dart';
part 'presence_model.g.dart';

@freezed
abstract class Presence with _$Presence {
  const factory Presence({
    required String userId,
    required String name,
    required String color,
    Cursor? cursor,
    Selection? selection,
    @Default(false) bool typing,
    DateTime? lastActive,
  }) = _Presence;

  factory Presence.fromJson(Map<String, dynamic> json) =>
      _$PresenceFromJson(json);

}

@freezed
abstract class Cursor with _$Cursor {
  const factory Cursor({
    required int index,
    required int length,
  }) = _Cursor;

  factory Cursor.fromJson(Map<String, dynamic> json) => _$CursorFromJson(json);
}
@freezed
abstract class Selection with _$Selection {
  const factory Selection({
    required int index,
    required int length,
    String? color,
  }) = _Selection;

  factory Selection.fromJson(Map<String, dynamic> json) =>
      _$SelectionFromJson(json);
}