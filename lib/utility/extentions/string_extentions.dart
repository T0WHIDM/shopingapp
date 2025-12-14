import 'package:flutter/material.dart';

extension ColorParsing on String? {
  Color parseToColor() {
    String stringColor = 'FF$this';
    int hexColor = int.parse(stringColor, radix: 16);

    return Color(hexColor);
  }
}
