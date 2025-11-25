import 'package:flutter/material.dart';

class ProjectArchitecture extends StatelessWidget {
  final dynamic project;

  const ProjectArchitecture({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (project.architecture == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Architettura",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surface.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              project.architecture!,
              style: const TextStyle(
                fontFamily: "monospace",
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
