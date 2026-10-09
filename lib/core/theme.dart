import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF0F766E),
    scaffoldBackgroundColor: const Color(0xFFF4F6F5),
    cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
  );
}
