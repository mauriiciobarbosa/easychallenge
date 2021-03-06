import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  InputField({
    required this.keyboardType,
    required this.label,
    required this.hint,
    required this.inputFormatter,
    required this.inputFieldController,
    required this.onChanged,
  });

  final TextInputType keyboardType;
  final String label;
  final String hint;
  final TextInputFormatter? inputFormatter;
  final TextEditingController inputFieldController;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      controller: inputFieldController,
      keyboardType: keyboardType,
      inputFormatters: [if (inputFormatter != null) inputFormatter!],
      onChanged: onChanged,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 24.0,
        ),
      ),
    );
  }
}
