import 'dart:io';

import 'package:currency_converter/config/constant.dart';
import 'package:dio/dio.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String apiKey = const String.fromEnvironment(AppConstant.apiKey);
    options.headers[HttpHeaders.authorizationHeader] = 'Bearer $apiKey';
    return handler.next(options);
  }
}
