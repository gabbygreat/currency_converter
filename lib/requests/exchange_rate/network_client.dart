import 'package:retrofit/retrofit.dart';

import '../../utils/utils.dart';

part 'network_client.g.dart';

@RestApi()
abstract class ExchangeRateApiClient {
  factory ExchangeRateApiClient(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ExchangeRateApiClient;

  @Cacheable()
  @GET('v6/{apiKey}/codes')
  Future<SupportedCodesResponse> getSupportedCodes({
    @Path('apiKey') required String apiKey,
  });

  @Cacheable()
  @GET('v6/{apiKey}/latest/USD')
  Future<ConversionRatesResponse> getConversionRates({
    @Path('apiKey') required String apiKey,
  });
}
