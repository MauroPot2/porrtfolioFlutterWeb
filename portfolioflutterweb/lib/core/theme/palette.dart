import 'package:flutter/material.dart';

class Palette {
  // Colori principali del brand
  static const Color primary = Color(0xFF8A2BE2); // Viola
  static const Color secondary = Color(0xFFFF6F00); // Arancio

  // Background (usati in app_theme come scaffoldBackgroundColor / surface)
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color darkBackground  = Color(0xFF121212);

  // Colori superficie (se vuoi differenziarli dai background in futuro)
  static const Color lightSurface = Colors.white;
  static const Color darkSurface  = Color(0xFF1E1E1E);

  // Testo per light/dark theme
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color darkText  = Color(0xFFFFFFFF);
}
