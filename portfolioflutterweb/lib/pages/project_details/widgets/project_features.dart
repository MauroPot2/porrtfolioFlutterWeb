import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/models/project.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';

class ProjectFeatures extends StatelessWidget {
  final Project project;

  const ProjectFeatures({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final features = project.features ?? const <String>[];

    if (features.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SectionContainer(
      maxWidth: 1100,
      color: colorScheme.surface.withValues(alpha: isDark ? 0.20 : 0.65),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Funzionalità principali',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 16.0;
              final columns = constraints.maxWidth < 700 ? 1 : 2;
              final cardWidth =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: features.map((feature) {
                  return Container(
                    width: cardWidth,
                    constraints: const BoxConstraints(minHeight: 76),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.16),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            size: 18,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.45,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.86,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
