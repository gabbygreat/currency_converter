import 'package:json_annotation/json_annotation.dart';

part 'conversion_rates_response.g.dart';

@JsonSerializable()
class ConversionRatesResponse {
  final String result;
  @JsonKey(name: 'conversion_rates')
  final ConversionRates conversionRates;

  const ConversionRatesResponse({
    required this.result,
    required this.conversionRates,
  });

  factory ConversionRatesResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversionRatesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConversionRatesResponseToJson(this);
}

@JsonSerializable(createToJson: false, createFactory: false)
class ConversionRates {
  final Map<String, double> rates;

  const ConversionRates({required this.rates});

  factory ConversionRates.fromJson(Map<String, dynamic> json) {
    final Map<String, double> rates = {};
    json.forEach((key, value) {
      rates[key] = (value as num).toDouble();
    });
    return ConversionRates(rates: rates);
  }

  Map<String, dynamic> toJson() => rates;

  // Helper methods
  double? getRate(String currencyCode) => rates[currencyCode];

  List<String> get supportedCurrencies => rates.keys.toList();

  bool hasCurrency(String currencyCode) => rates.containsKey(currencyCode);
}

extension ConversionRatesX on ConversionRates {
  /// Get the rate for a currency code (e.g. "USD")
  double? getRate(String code) => rates[code];

  /// List of all supported currency codes
  List<String> get supportedCurrencies => rates.keys.toList();

  /// Check if a currency exists
  bool hasCurrency(String code) => rates.containsKey(code);
}
