import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/models/project.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';

class ProjectArchitecture extends StatelessWidget {
  final Project project;

  const ProjectArchitecture({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final architecture = project.architecture?.trim() ?? '';

    if (architecture.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SectionContainer(
      maxWidth: 1100,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Architettura e tecnologie',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF111827) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CodeHeader(colorScheme: colorScheme),
                Divider(
                  height: 1,
                  color: colorScheme.outline.withValues(alpha: 0.14),
                ),
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(22),
                    child: Text(
                      architecture,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        height: 1.65,
                        color: isDark
                            ? const Color(0xFFE5E7EB)
                            : const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeHeader extends StatelessWidget {
  final ColorScheme colorScheme;

  const _CodeHeader({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
      child: Row(
        children: [
          Icon(
            Icons.account_tree_outlined,
            size: 19,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Text(
            'Struttura tecnica',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}
