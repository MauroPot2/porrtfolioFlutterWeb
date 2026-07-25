import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/data/projects.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';

class ProjectsHeroSection extends StatelessWidget {
  const ProjectsHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SectionContainer(
      minHeight: 430,
      color: colorScheme.primary.withValues(alpha: isDark ? 0.08 : 0.05),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 760;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'PORTFOLIO',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Progetti costruiti\nper problemi reali.',
                style: TextStyle(
                  fontSize: isCompact ? 40 : 58,
                  height: 1.05,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.2,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 820),
                child: Text(
                  'Una selezione di applicazioni e piattaforme sviluppate '
                  'per gestire prenotazioni, dati, contenuti e processi '
                  'operativi. Ogni caso studio racconta il problema, '
                  'le scelte tecniche e la soluzione realizzata.',
                  style: TextStyle(
                    fontSize: isCompact ? 17 : 20,
                    height: 1.65,
                    color: colorScheme.onSurface.withValues(alpha: 0.74),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _HeroInfoChip(
                    icon: Icons.layers_outlined,
                    label: '${myProjects.length} progetti selezionati',
                  ),
                  const _HeroInfoChip(
                    icon: Icons.phone_iphone_rounded,
                    label: 'Mobile e web',
                  ),
                  const _HeroInfoChip(
                    icon: Icons.account_tree_outlined,
                    label: 'Frontend e backend',
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroInfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface.withValues(alpha: 0.82),
            ),
          ),
        ],
      ),
    );
  }
}
