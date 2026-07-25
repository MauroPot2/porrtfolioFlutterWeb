import 'package:flutter/material.dart';

import 'section_container.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentYear = DateTime.now().year;

    return SectionContainer(
      maxWidth: 1200,
      color: colorScheme.surface.withValues(
        alpha: isDark ? 0.28 : 0.92,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 28,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 620;

          final copyright = Text(
            '© $currentYear Mauro Leonardo Potestio',
            textAlign: isCompact ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface.withValues(alpha: 0.72),
            ),
          );

          final technology = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.flutter_dash_rounded,
                size: 18,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 7),
              Text(
                'Realizzato con Flutter Web',
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurface.withValues(alpha: 0.66),
                ),
              ),
            ],
          );

          if (isCompact) {
            return Column(
              children: [
                copyright,
                const SizedBox(height: 12),
                technology,
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              copyright,
              technology,
            ],
          );
        },
      ),
    );
  }
}
