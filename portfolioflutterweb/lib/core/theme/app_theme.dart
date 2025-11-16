import 'package:flutter/material.dart';
import 'palette.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.primary,
      primary: Palette.primary,
      secondary: Palette.accent,
      ),
  useMaterial3: true,
  scaffoldBackgroundColor: Palette.background,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 22),
    bodyMedium: TextStyle(fontSize: 16),
  ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(
      primary: Palette.primary,
      secondary: Palette.accent,
    )
  );
}