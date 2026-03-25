import 'package:json_annotation/json_annotation.dart';

class DateTimeIso8601Converter implements JsonConverter<DateTime, String> {
  const DateTimeIso8601Converter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.toUtc().toIso8601String();
  }
}
