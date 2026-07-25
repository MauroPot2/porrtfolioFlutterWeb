import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/models/project.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';

class ProjectOverview extends StatelessWidget {
  final Project project;

  const ProjectOverview({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final description = project.descriptionLong?.trim().isNotEmpty ?? false
        ? project.descriptionLong!.trim()
        : project.description.trim();

    return SectionContainer(
      maxWidth: 1100,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Il progetto',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 17,
                height: 1.75,
                color: colorScheme.onSurface.withValues(alpha: 0.80),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
