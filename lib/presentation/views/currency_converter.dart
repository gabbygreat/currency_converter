import 'package:currency_converter/utils/utils.dart';

class CurrencyConverter extends StatefulWidget {
  final ConversionRatesResponse conversionRates;
  const CurrencyConverter({super.key, required this.conversionRates});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  (String, String) exchangeRate = ('', '');

  void _onExchangeRateUpdated((String, String) value) {
    setState(() => exchangeRate = value);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.spMin, vertical: 20.spMin),
      children: [
        50.sbH,
        Center(child: Text('Currency Converter', style: 25.w700.x1F2261)),
        10.sbH,
        Center(
          child: Text(
            'Check live rates, set rate alerts, receive notifications and more.',
            style: 16.w400.x808080,
            textAlign: TextAlign.center,
          ),
        ),
        41.sbH,
        CurrencyConverterCard(
          conversionRates: widget.conversionRates,
          onExchangeRateUpdated: _onExchangeRateUpdated,
        ),
        30.sbH,
        IndicativeExchangeRate(
          conversionRates: widget.conversionRates,
          exchangeRate: exchangeRate,
        ),
      ],
    );
  }
}
