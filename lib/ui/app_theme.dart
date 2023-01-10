import 'package:flutter/material.dart';

enum AppTheme {
  // ignore: constant_identifier_names
  LightTheme,
  // ignore: constant_identifier_names
  DarkTheme
}

final appThemeData = {
  AppTheme.LightTheme: ThemeData(
      fontFamily: 'Rubik',
      primaryColor: const Color(0xFFE95885),
      scaffoldBackgroundColor: const Color(0xFFffffff),
      shadowColor: Colors.black.withOpacity(0.1),
      brightness: Brightness.light),
  AppTheme.DarkTheme: ThemeData(
      fontFamily: 'Rubik',
      primaryColor: const Color(0xFFE95885),
      scaffoldBackgroundColor: const Color(0xFF1C2227),
      shadowColor: Colors.white.withOpacity(0.025),
      brightness: Brightness.dark)
};
