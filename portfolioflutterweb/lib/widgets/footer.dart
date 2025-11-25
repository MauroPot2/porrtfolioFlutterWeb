import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = cs.brightness == Brightness.dark;

    // 🔥 Colore sfondo moderno con withValues
    final background = cs.surface.withValues(
      alpha: isDark ? 0.15 : 0.95,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      color: background,
      child: Center(
        child: Text(
          "© 2025 Mauro Leonardo Potestio — Tutti i diritti riservati",
          style: TextStyle(
            color: cs.onSurface.withValues(alpha: 0.85),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
