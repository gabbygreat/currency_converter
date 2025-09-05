import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/utils.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitial;

  const factory HomeState.loading() = HomeLoading;

  const factory HomeState.loaded({
    required ConversionRatesResponse conversionRates,
  }) = HomeLoaded;

  const factory HomeState.error({required ErrorModel error}) = HomeError;
}
