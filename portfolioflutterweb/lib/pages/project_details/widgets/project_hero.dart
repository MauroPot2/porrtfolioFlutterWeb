import 'package:flutter/material.dart';

class ProjectHero extends StatelessWidget {
  final dynamic project;

  const ProjectHero({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: cs.surface.withValues(alpha: 0.95),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          if (project.subtitle != null) ...[
            const SizedBox(height: 12),
            Text(
              project.subtitle!,
              style: TextStyle(
                fontSize: 18,
                color: cs.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
