import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_doc/models/user_model.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
abstract class CommentModel with _$CommentModel {
  const factory CommentModel({
    required String id,
    required String documentId,
    required String userId,
    required  Anchor anchor,
    required String content,
    @Default(false) bool resolved,
    String? resolvedBy,
    DateTime? resolvedAt,
    @Default([]) List<ReplyModel> replies,
    @Default('comment') String type, // comment, suggestion
    Map<String, dynamic>? suggestedDelta,
    DateTime? createdAt,
    DateTime? updatedAt,
    
    // Populated fields
    UserModel? user,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}

@freezed
abstract class Anchor with _$Anchor {
  const factory Anchor({
    required int index,
    @Default(0) int length,
  }) = _Anchor;

  factory Anchor.fromJson(Map<String, dynamic> json) => _$AnchorFromJson(json);
}

@freezed
abstract class ReplyModel with _$ReplyModel {
  const factory ReplyModel({
    required String userId,
    required String content,
    DateTime? createdAt,
    
    // Populated fields
    UserModel? user,
  }) = _ReplyModel;

  factory ReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyModelFromJson(json);
}