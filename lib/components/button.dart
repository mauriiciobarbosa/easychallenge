import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.maxFinite, 48),
        textStyle: TextStyle(
          fontSize: 20.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
          side: BorderSide(color: Colors.white),
        ),
      ),
      child: Text(text),
    );
  }
}
