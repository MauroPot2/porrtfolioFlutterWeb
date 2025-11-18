import 'package:flutter/material.dart';
import '../../../data/projects.dart';
import 'package:portfolioflutterweb/widgets/project_card.dart';

class ProjectsGridSection extends StatelessWidget {
  const ProjectsGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        children: [
          for (final project in myProjects) ProjectCard(project: project),
        ],
      ),
    );
  }
}
