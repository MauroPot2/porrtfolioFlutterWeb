import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/data/projects.dart';
import 'package:portfolioflutterweb/widgets/project_card.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';

class ProjectsGridSection extends StatelessWidget {
  const ProjectsGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SectionContainer(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Casi studio',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Apri un progetto per vedere funzionalità, architettura, '
              'scelte tecniche, codice e schermate.',
              style: TextStyle(
                fontSize: 17,
                height: 1.6,
                color: colorScheme.onSurface.withValues(alpha: 0.70),
              ),
            ),
          ),
          const SizedBox(height: 36),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = switch (constraints.maxWidth) {
                >= 1050 => 3,
                >= 680 => 2,
                _ => 1,
              };

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myProjects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 440,
                ),
                itemBuilder: (context, index) {
                  return ProjectCard(project: myProjects[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
