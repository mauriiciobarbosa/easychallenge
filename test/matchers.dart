import 'package:easynvest_app/components/button.dart';
import 'package:easynvest_app/components/input_field.dart';
import 'package:easynvest_app/components/result_header.dart';
import 'package:easynvest_app/components/result_row.dart';
import 'package:flutter/material.dart';

bool findFieldWithHintAndLabel(Widget widget, String hint, String label) {
  return widget is InputField && widget.hint == hint && widget.label == label;
}

bool findButtonWithText(Widget widget, String text, {bool isEnabled = true}) {
  final buttonState = (Button button) {
    return isEnabled ? button.onPressed != null : button.onPressed == null;
  };

  return widget is Button && widget.text == text && buttonState.call(widget);
}

bool findRowWithTitleAndDescription(
  Widget widget,
  String title,
  String description,
) {
  return widget is ResultRow &&
      widget.title == title &&
      widget.description == description;
}

bool findHeaderWithGrossAmountAndNetAmountProfit(
  Widget widget,
  String grossAmount,
  String netAmountProfit,
) {
  return widget is ResultHeader &&
      widget.grossAmount == grossAmount &&
      widget.netAmountProfit == netAmountProfit;
}
