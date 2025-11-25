import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Competenze",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: const [
              SkillCard("Flutter / Dart"),
              SkillCard("Python / Flask"),
              SkillCard("HTML / CSS"),
              SkillCard("SQL / REST API"),
              SkillCard("Linux / DevOps Basics"),
            ],
          )
        ],
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final String label;
  const SkillCard(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),

        // Background dinamico in base al tema
        color: isDark
            ? colorScheme.surface.withValues()
            : colorScheme.surface.withValues(),

        // Shadow dinamico
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: isDark
                ? Colors.black.withValues()
                : Colors.grey.withValues(),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
