import 'package:flutter/services.dart';

class SinglePeriodEnforcer extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    // Allow only digits and at most one period
    final filtered = newText.replaceAll(RegExp(r'[^0-9.]'), '');
    if ('.'.allMatches(filtered).length <= 1) {
      return newValue.copyWith(
        text: filtered,
        selection: updateCursorPosition(filtered, newValue.selection),
      );
    }
    return oldValue;
  }

  // Helper to update the cursor position after filtering
  TextSelection updateCursorPosition(String text, TextSelection selection) {
    final offset = text.length < selection.baseOffset
        ? text.length
        : selection.baseOffset;
    return TextSelection.collapsed(offset: offset);
  }
}
