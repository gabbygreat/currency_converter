import 'package:flutter/foundation.dart';

void kLog(
  Object message, {
  StackTrace? stackTrace,
}) {
  if (kDebugMode) {
    debugPrint('$message');
    if (stackTrace != null) {
      debugPrint(
        '[STACK TRACE] => $stackTrace',
      );
    }
  }
}
