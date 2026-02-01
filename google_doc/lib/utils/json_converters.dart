import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const TimestampConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is DateTime) return json;
    if (json is String) return DateTime.parse(json);
    if (json is Map && json['_seconds'] != null) {
      // Firestore timestamp format (if backend sends this)
      return DateTime.fromMillisecondsSinceEpoch(
        (json['_seconds'] as num).toInt() * 1000 + ((json['_nanoseconds'] as num?)?.toInt() ?? 0) ~/ 1000000,
      );
    }
    return null;
  }

  @override
  dynamic toJson(DateTime? object) {
    if (object == null) return null;
    return object.toIso8601String();
  }
}

class StringListConverter implements JsonConverter<List<String>?, dynamic> {
  const StringListConverter();

  @override
  List<String>? fromJson(dynamic json) {
    if (json == null) return null;
    return (json as List).map((e) => e.toString()).toList();
  }

  @override
  List<String>? toJson(List<String>? object) => object;
}