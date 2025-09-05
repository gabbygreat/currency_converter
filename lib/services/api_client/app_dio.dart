import 'package:dio/dio.dart' show Headers, DioMixin, Dio, BaseOptions;
import 'package:dio/io.dart';

import '../../utils/utils.dart';

class AppDio with DioMixin implements Dio {
  AppDio._() {
    options = BaseOptions(
      baseUrl: const String.fromEnvironment(AppConstant.baseUrl),
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 50),
      sendTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
    );

    interceptors.addAll([CacheInterceptor(), RequestInterceptor()]);

    httpClientAdapter = IOHttpClientAdapter();
  }

  static Dio getInstance() => AppDio._();
}
