import 'package:flutter/material.dart';
import 'palette.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Palette.lightBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Palette.primary,
      onPrimary: Colors.white,
      secondary: Palette.secondary,
      onSecondary: Colors.white,
      surface: Palette.lightBackground,
      onSurface: Palette.lightText,
      error: Colors.red,
      onError: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Palette.darkBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Palette.primary,
      onPrimary: Colors.black,
      secondary: Palette.secondary,
      onSecondary: Colors.black,
      surface: Palette.darkBackground,
      onSurface: Palette.darkText,
      error: Colors.red,
      onError: Colors.black,
    ),
  );
}
