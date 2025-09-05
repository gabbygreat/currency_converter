import 'package:currency_converter/domain/exchange_rate_use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/utils.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  final ExchangeRateUseCase _exchangeRateUseCase;

  HomeViewModel(this._exchangeRateUseCase) : super(HomeState.initial()) {
    state = HomeState.loading();
    _exchangeRateUseCase
        .getConversionRates()
        .then((value) {
          state = HomeState.loaded(conversionRates: value);
        })
        .catchError((error) {
          final errorModel = ApiFormatter.format(error);
          state = HomeState.error(error: errorModel);
        });
  }
}
