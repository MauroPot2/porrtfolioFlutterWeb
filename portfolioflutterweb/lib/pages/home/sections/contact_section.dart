import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = cs.brightness == Brightness.dark;

    // 🔥 Sfumatura coerente con M3 e withValues
    final bgColor = cs.surface.withValues(
      alpha: isDark ? 0.20 : 0.95,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: bgColor,
      child: Column(
        children: [
          Text(
            "Contattami",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Per collaborazioni, progetti o semplici curiosità.",
            style: TextStyle(
              color: cs.onSurface.withValues(alpha: 0.85),
            ),
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: cs.primary.withValues(alpha: 0.90),
              foregroundColor: cs.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )
            ),
            onPressed: () {},
            child: const Text(
              "Scrivimi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
