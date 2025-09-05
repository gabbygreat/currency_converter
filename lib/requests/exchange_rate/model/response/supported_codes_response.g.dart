// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_codes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportedCodesResponse _$SupportedCodesResponseFromJson(
  Map<String, dynamic> json,
) => SupportedCodesResponse(
  result: json['result'] as String,
  supportedCodes: (json['supported_codes'] as List<dynamic>)
      .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
      .toList(),
);

Map<String, dynamic> _$SupportedCodesResponseToJson(
  SupportedCodesResponse instance,
) => <String, dynamic>{
  'result': instance.result,
  'supported_codes': instance.supportedCodes,
};
