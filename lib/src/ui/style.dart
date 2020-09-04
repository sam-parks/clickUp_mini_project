import 'package:flutter/material.dart';

final kClickUpTheme = ThemeData(
  primaryColor: AppColors.orange,
  primaryColorDark: AppColors.purple,
  accentColor: AppColors.pink,
  backgroundColor: Colors.white,
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
  ),
);

const String kFontFamilyNormal = 'Mermaid';

class AppColors {
  static List<Color> allColors = [
    orange,
    orange_pink,
    pink,
    violet,
    deep_violet,
    light_blue,
    purple_blue,
    purple
  ];

  AppColors._();
  static const Color background = Color(0xFFFAFBFC);

  static const Color orange = Color(0xFFFEB53D);
  static const Color orange_pink = Color(0xFFFF8E7B);
  static const Color pink = Color(0xFFFF7794);
  static const Color violet = Color(0xFFFF58B5);
  static const Color deep_violet = Color(0xFFFF33D7);

  static const Color light_blue = Color(0xFF5AB7FA);
  static const Color purple_blue = Color(0xFF757DFC);
  static const Color purple = Color(0xFF8642FD);
}
