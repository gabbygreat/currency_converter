import '../../utils/utils.dart';

abstract class ExchangeRateApiService extends NetworkBoundResources {
  ExchangeRateApiService(this._client);

  final ExchangeRateApiClient _client;

  Future<ConversionRatesResponse> getConversionRates();
  Future<SupportedCodesResponse> getSupportedCodes();
}

class DefaultExchangeRateApiService extends ExchangeRateApiService {
  DefaultExchangeRateApiService(super.client);

  @override
  Future<ConversionRatesResponse> getConversionRates() async {
    final apiKey = const String.fromEnvironment(AppConstant.apiKey);
    return networkBoundResponse(
      fromRemote: _client.getConversionRates(apiKey: apiKey),
    );
  }

  @override
  Future<SupportedCodesResponse> getSupportedCodes() async {
    final apiKey = const String.fromEnvironment(AppConstant.apiKey);
    return networkBoundResponse(
      fromRemote: _client.getSupportedCodes(apiKey: apiKey),
    );
  }
}
