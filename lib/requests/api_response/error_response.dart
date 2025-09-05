import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  ErrorResponse({required this.result, required this.errorType});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  final String result;
  @JsonKey(name: "error-type")
  final String errorType;

  static ErrorResponse? nullableFromJson(Map<String, dynamic> json) {
    try {
      return ErrorResponse.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
