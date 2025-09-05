import '../utils/utils.dart';

double calculateConversion({
  required double amount,
  required String fromCurrency,
  required String toCurrency,
  required ConversionRates conversionRates,
}) {
  if (fromCurrency == toCurrency) return amount;

  final rates = conversionRates.rates;

  final fromRate = rates[fromCurrency];
  final toRate = rates[toCurrency];

  if (fromRate == null) {
    throw Exception('Rate not available for $fromCurrency');
  }
  if (toRate == null) {
    throw Exception('Rate not available for $toCurrency');
  }

  return ((amount / fromRate) * toRate);
}
