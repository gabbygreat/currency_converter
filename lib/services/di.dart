import 'package:get_it/get_it.dart';
import '../utils/utils.dart';

final locator = GetIt.instance;

Future<void> setupDeps() async {
  locator
    ..registerSingletonAsync<ILocalStorage>(() async {
      final storage = LocalStorage();
      await storage.initialise();
      return storage;
    })
    ..registerSingletonAsync<Dio>(
      () async => AppDio.getInstance(),
      dependsOn: [ILocalStorage],
    )
    // API SERVICE
    ..registerSingletonAsync<ExchangeRateApiService>(
      () async => DefaultExchangeRateApiService(
        ExchangeRateApiClient(locator<Dio>()),
      ),
      dependsOn: [Dio],
    );

  await locator.allReady();
}
