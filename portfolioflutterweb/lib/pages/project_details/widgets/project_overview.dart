import 'package:flutter/material.dart';

class ProjectOverview extends StatelessWidget {
  final dynamic project;

  const ProjectOverview({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Overview",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            project.descriptionLong ?? project.description,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: cs.onSurface.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}
