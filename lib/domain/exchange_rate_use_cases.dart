import '../utils/utils.dart';

class ExchangeRateUseCase {
  final ExchangeRateApiService _repository;

  ExchangeRateUseCase(this._repository);

  Future<SupportedCodesResponse> getSupportedCodes() async {
    return await _repository.getSupportedCodes();
  }

  Future<ConversionRatesResponse> getConversionRates() async {
    return await _repository.getConversionRates();
  }
}
