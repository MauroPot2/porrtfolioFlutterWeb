import 'package:flutter/material.dart';
import 'palette.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Palette.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: Palette.primary,
      secondary: Palette.accent,
      background: Palette.backgroundLight,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Palette.textDark,
      onSurface: Palette.textDark,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Palette.textDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        color: Palette.textDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Palette.textDark,
      ),
      bodySmall: TextStyle(
        color: Palette.textDark,
      ),
      titleLarge: TextStyle(
        color: Palette.textDark,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Palette.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: Palette.primary,
      secondary: Palette.accent,
      background: Palette.backgroundDark,
      surface: Color(0xFF1E1E1E),
      onPrimary: Palette.textLight,
      onSecondary: Palette.textLight,
      onBackground: Palette.textLight,
      onSurface: Palette.textLight,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Palette.textLight),
      bodySmall: TextStyle(color: Palette.textLight),
      titleLarge: TextStyle(color: Palette.textLight),
      headlineMedium: TextStyle(color: Palette.textLight),
      displayLarge: TextStyle(color: Palette.textLight),
    ),
  );
}
