import 'dart:math';

import '../utils/utils.dart';

extension NumExtension on num {
  SizedBox get sbH => SizedBox(height: spMin);
  SizedBox get sbW => SizedBox(width: spMin);
}

extension DoubleExtensions on double {
  String toSignificantFigures(int sigFigs) {
    if (this == 0) return '0';

    final absValue = abs();
    final magnitude = (log(absValue) / ln10).floor();
    final factor = pow(10, sigFigs - magnitude - 1);
    final rounded = (this * factor).round() / factor;

    final decimalPlaces = max(0, sigFigs - magnitude - 1);

    if (decimalPlaces <= 0) {
      return rounded.toStringAsFixed(0);
    } else {
      String result = rounded.toStringAsFixed(decimalPlaces);
      // Remove trailing zeros after decimal
      result = result.replaceAll(RegExp(r'\.?0+$'), '');
      return result;
    }
  }
}
