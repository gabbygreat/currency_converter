import 'package:currency_converter/utils/utils.dart';

class IndicativeExchangeRate extends StatelessWidget {
  final (String, String) exchangeRate;
  final ConversionRatesResponse conversionRates;
  const IndicativeExchangeRate({
    super.key,
    required this.exchangeRate,
    required this.conversionRates,
  });

  @override
  Widget build(BuildContext context) {
    final amount = 1.0;

    final conversion = calculateConversion(
      amount: amount,
      fromCurrency: exchangeRate.$1,
      toCurrency: exchangeRate.$2,
      conversionRates: conversionRates.conversionRates,
    ).toSignificantFigures(5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Indicative Exchange Rate', style: 16.w400.xA1A1A1),
        13.sbH,
        Text(
          '1 ${exchangeRate.$1} = $conversion ${exchangeRate.$2}',
          style: 18.w500.x000000,
        ),
      ],
    );
  }
}
