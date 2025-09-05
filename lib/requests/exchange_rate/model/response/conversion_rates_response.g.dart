// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversion_rates_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversionRatesResponse _$ConversionRatesResponseFromJson(
  Map<String, dynamic> json,
) => ConversionRatesResponse(
  result: json['result'] as String,
  conversionRates: ConversionRates.fromJson(
    json['conversion_rates'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ConversionRatesResponseToJson(
  ConversionRatesResponse instance,
) => <String, dynamic>{
  'result': instance.result,
  'conversion_rates': instance.conversionRates,
};
