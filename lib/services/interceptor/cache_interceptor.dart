import 'dart:convert';
import 'package:retrofit/dio.dart';
import '../../utils/utils.dart';

@immutable
class Cacheable extends TypedExtras {
  final bool isCacheable;

  const Cacheable({this.isCacheable = true});
}

class CacheInterceptor extends Interceptor {
  late ILocalStorage storage;
  final Duration defaultCacheDuration;

  CacheInterceptor({this.defaultCacheDuration = const Duration(days: 3)}) {
    _init();
  }

  Future<void> _init() async {
    storage = locator<ILocalStorage>();
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final key = _getCacheKey(options);
    final isCachable = _isCachable(options);

    if (isCachable) {
      final cacheDuration = _getCacheDuration(options);
      final cachedData = _getCachedData(key);

      if (cachedData != null && _isCacheValid(cachedData, cacheDuration)) {
        final cachedResponse = Response(
          requestOptions: options,
          statusCode: 200,
          data: cachedData['data'],
        );
        return handler.resolve(cachedResponse);
      } else {
        storage.remove(key);
      }
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final key = _getCacheKey(response.requestOptions);

    if (_isCachable(response.requestOptions)) {
      await _saveToCache(key, response.data);
    }

    handler.next(response);
  }

  // Get cache duration from request options or use default
  Duration _getCacheDuration(RequestOptions options) {
    final cacheDurationMinutes = options.extra['cacheDurationMinutes'] as int?;
    if (cacheDurationMinutes != null) {
      return Duration(minutes: cacheDurationMinutes);
    }

    final cacheDurationHours = options.extra['cacheDurationHours'] as int?;
    if (cacheDurationHours != null) {
      return Duration(hours: cacheDurationHours);
    }

    final cacheDurationDays = options.extra['cacheDurationDays'] as int?;
    if (cacheDurationDays != null) {
      return Duration(days: cacheDurationDays);
    }

    return defaultCacheDuration;
  }

  // Check if cache is valid with custom duration
  bool _isCacheValid(Map<String, dynamic> cachedData, Duration duration) {
    final timestampStr = cachedData['timestamp'] as String?;
    if (timestampStr == null) return false;

    try {
      final timestamp = DateTime.parse(timestampStr);
      final now = DateTime.now();
      final difference = now.difference(timestamp);

      return difference <= duration;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic>? _getCachedData(String key) {
    final cachedJson = storage.getString(key);
    if (cachedJson == null) return null;

    try {
      return jsonDecode(cachedJson) as Map<String, dynamic>;
    } catch (e) {
      storage.remove(key);
      return null;
    }
  }

  Future<void> _saveToCache(String key, dynamic data) async {
    final cacheData = {
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    };

    final json = jsonEncode(cacheData);
    await storage.setString(key, json);
  }

  String _getCacheKey(RequestOptions options) =>
      '${options.method}:${options.uri.toString()}';

  bool _isCachable(RequestOptions options) {
    final cacheable = options.extra['isCacheable'];
    return cacheable is bool && cacheable;
  }
}
