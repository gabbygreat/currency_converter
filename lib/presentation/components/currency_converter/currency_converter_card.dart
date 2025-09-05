import '../../../utils/utils.dart';

class CurrencyConverterCard extends StatefulWidget {
  final ConversionRatesResponse conversionRates;
  final void Function((String, String)) onExchangeRateUpdated;

  const CurrencyConverterCard({
    super.key,
    required this.conversionRates,
    required this.onExchangeRateUpdated,
  });

  @override
  State<CurrencyConverterCard> createState() => _CurrencyConverterCardState();
}

class _CurrencyConverterCardState extends State<CurrencyConverterCard> {
  late final ValueNotifier<String> amountCurrencyCodeNotifier;
  late final ValueNotifier<String> convertedAmountCurrencyCodeNotifier;
  late final List<String> supportedCurrencies;
  late TextEditingController amountTextEditingController;
  late TextEditingController convertTextEditingController;

  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    supportedCurrencies =
        widget.conversionRates.conversionRates.supportedCurrencies;
    amountCurrencyCodeNotifier = ValueNotifier(supportedCurrencies[0]);
    convertedAmountCurrencyCodeNotifier = ValueNotifier(supportedCurrencies[1]);
    amountTextEditingController = TextEditingController()
      ..addListener(amountRateListener);
    convertTextEditingController = TextEditingController()
      ..addListener(convertRateListener);

    amountCurrencyCodeNotifier.addListener(_onCurrencyChanged);
    convertedAmountCurrencyCodeNotifier.addListener(_onCurrencyChanged);
    Future.microtask(() => _updateExchangeRate());
  }

  @override
  void dispose() {
    convertTextEditingController.removeListener(convertRateListener);
    amountTextEditingController.removeListener(amountRateListener);
    amountCurrencyCodeNotifier.removeListener(_onCurrencyChanged);
    convertedAmountCurrencyCodeNotifier.removeListener(_onCurrencyChanged);

    convertTextEditingController.dispose();
    amountTextEditingController.dispose();
    amountCurrencyCodeNotifier.dispose();
    convertedAmountCurrencyCodeNotifier.dispose();
    super.dispose();
  }

  List<String> getCurrencyList() {
    final amountCurrencyCode = amountCurrencyCodeNotifier.value;
    final convertedAmountCurrencyCode =
        convertedAmountCurrencyCodeNotifier.value;
    final finalList = [...supportedCurrencies];
    finalList.removeWhere(
      (e) => e == amountCurrencyCode || e == convertedAmountCurrencyCode,
    );
    return finalList;
  }

  void openCurrencyListMenu(int selectionPosition) async {
    final currencies = getCurrencyList();
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final String? selectedCurrency = await showMenu<String>(
      context: context,
      position: position,
      color: Colors.white,
      items: currencies
          .map(
            (currency) =>
                PopupMenuItem<String>(value: currency, child: Text(currency)),
          )
          .toList(),
    );

    if (selectedCurrency == null) return;

    if (selectionPosition == 1) {
      amountCurrencyCodeNotifier.value = selectedCurrency;
    } else {
      convertedAmountCurrencyCodeNotifier.value = selectedCurrency;
    }
  }

  void _updateExchangeRate() {
    widget.onExchangeRateUpdated((
      amountCurrencyCodeNotifier.value,
      convertedAmountCurrencyCodeNotifier.value,
    ));
  }

  void _onCurrencyChanged() {
    if (_isUpdating) return;

    final amountText = amountTextEditingController.text;
    if (amountText.isNotEmpty) {
      final amount = double.tryParse(amountText);
      if (amount != null && amount > 0) {
        _performConversion(
          amount: amount,
          fromCurrency: amountCurrencyCodeNotifier.value,
          toCurrency: convertedAmountCurrencyCodeNotifier.value,
          updateField: _updateConvertedAmount,
        );
      }
    }

    _updateExchangeRate();
  }

  // Update converted amount field without triggering listener
  void _updateConvertedAmount(String value) {
    _isUpdating = true;
    convertTextEditingController.text = value;
    _isUpdating = false;
  }

  // Add these methods for better user experience
  void amountRateListener() {
    if (_isUpdating) return;

    final amountText = amountTextEditingController.text;

    // Clear converted field if amount is empty
    if (amountText.isEmpty) {
      _updateConvertedAmount('');
      return;
    }

    // Validate input
    final amount = double.tryParse(amountText);
    if (amount == null) {
      // Invalid input - could show error state
      return;
    }

    // Prevent negative amounts
    if (amount < 0) {
      _updateAmount('0');
      return;
    }

    _performConversion(
      amount: amount,
      fromCurrency: amountCurrencyCodeNotifier.value,
      toCurrency: convertedAmountCurrencyCodeNotifier.value,
      updateField: _updateConvertedAmount,
    );
  }

  // Update amount field without triggering listener
  void _updateAmount(String value) {
    _isUpdating = true;
    amountTextEditingController.text = value;
    _isUpdating = false;
  }

  void convertRateListener() {
    if (_isUpdating) return;

    final convertedText = convertTextEditingController.text;

    // Clear amount field if converted amount is empty
    if (convertedText.isEmpty) {
      _updateAmount('');
      return;
    }

    // Validate input
    final convertedAmount = double.tryParse(convertedText);
    if (convertedAmount == null) {
      // Invalid input - could show error state
      return;
    }

    // Prevent negative amounts
    if (convertedAmount < 0) {
      _updateConvertedAmount('0');
      return;
    }

    _performConversion(
      amount: convertedAmount,
      fromCurrency: convertedAmountCurrencyCodeNotifier.value,
      toCurrency: amountCurrencyCodeNotifier.value,
      updateField: _updateAmount,
    );
  }

  void _performConversion({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
    required Function(String) updateField,
  }) {
    try {
      final convertedAmount = calculateConversion(
        amount: amount,
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        conversionRates: widget.conversionRates.conversionRates,
      );

      final formattedAmount = convertedAmount.toSignificantFigures(5);
      updateField(formattedAmount);
    } catch (e) {
      updateField('-');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.spMin),
      decoration: BoxDecoration(
        color: AppColors.xFFFFFF,
        border: Border.all(color: AppColors.xE7E7EE, width: 1),
        borderRadius: BorderRadius.circular(20.spMin),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            color: Color(0x0D000000),
            blurRadius: 4.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: MultiValueListenableBuilder(
        valueListenables: [
          amountCurrencyCodeNotifier,
          convertedAmountCurrencyCodeNotifier,
        ],
        builder: (context, listenable, _) {
          final amountCurrencyCode = listenable[0] as String;
          final convertedAmountCurrencyCode = listenable[1] as String;
          return Column(
            spacing: 15.spMin,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConvertSection(
                position: 1,
                title: 'Amount',
                currencyCode: amountCurrencyCode,
                controller: amountTextEditingController,
                onSelection: openCurrencyListMenu,
              ),
              ConvertDivider(),
              ConvertSection(
                position: 2,
                title: 'Converted Amount',
                currencyCode: convertedAmountCurrencyCode,
                controller: convertTextEditingController,
                onSelection: openCurrencyListMenu,
              ),
            ],
          );
        },
      ),
    );
  }
}
