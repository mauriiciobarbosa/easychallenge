import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// TODO implementar depois
class ValueFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatter = NumberFormat.decimalPattern('pt_BR');
    final value = newValue.text.replaceAll('%', '');

    if (value.length > 3) return oldValue;

    return newValue;
  }
}
