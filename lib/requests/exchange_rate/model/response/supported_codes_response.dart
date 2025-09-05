// lib/models/supported_codes_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'supported_codes_response.g.dart';

@JsonSerializable()
class SupportedCodesResponse {
  final String result;
  @JsonKey(name: 'supported_codes')
  final List<List<String>> supportedCodes;

  const SupportedCodesResponse({
    required this.result,

    required this.supportedCodes,
  });

  factory SupportedCodesResponse.fromJson(Map<String, dynamic> json) =>
      _$SupportedCodesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupportedCodesResponseToJson(this);
}
