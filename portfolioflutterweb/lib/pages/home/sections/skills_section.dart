import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';
import 'package:portfolioflutterweb/widgets/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _groups = [
    _SkillGroup(
      icon: Icons.phone_android_rounded,
      title: 'Mobile e UI',
      skills: ['Flutter', 'Dart', 'Material 3', 'Responsive UI'],
    ),
    _SkillGroup(
      icon: Icons.account_tree_rounded,
      title: 'Architettura',
      skills: ['Riverpod', 'GoRouter', 'Clean Architecture', 'REST API'],
    ),
    _SkillGroup(
      icon: Icons.storage_rounded,
      title: 'Backend e dati',
      skills: ['Firebase', 'Cloud Firestore', 'Supabase', 'Python / Flask'],
    ),
    _SkillGroup(
      icon: Icons.build_circle_rounded,
      title: 'Tooling e delivery',
      skills: [
        'Git / GitHub',
        'GitHub Actions',
        'Docker',
        'Linux',
        'RevenueCat',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Competenze'),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Text(
              'Tecnologie che utilizzo per costruire prodotti completi, '
              'manutenibili e pronti per utenti reali.',
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
                color: cs.onSurface.withValues(alpha: 0.70),
              ),
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 24.0;
              final columns = constraints.maxWidth >= 760 ? 2 : 1;
              final cardWidth =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final group in _groups)
                    _SkillGroupCard(group: group, width: cardWidth),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillGroup {
  final IconData icon;
  final String title;
  final List<String> skills;

  const _SkillGroup({
    required this.icon,
    required this.title,
    required this.skills,
  });
}

class _SkillGroupCard extends StatelessWidget {
  final _SkillGroup group;
  final double width;

  const _SkillGroupCard({required this.group, required this.width});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: width,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.75)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(group.icon, color: cs.primary, size: 25),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  group.title,
                  style: TextStyle(
                    color: cs.onSurface,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final skill in group.skills)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: cs.primary.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      color: cs.onSurface.withValues(alpha: 0.84),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
