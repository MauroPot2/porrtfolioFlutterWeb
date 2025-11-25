import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/widgets/footer.dart';
import 'package:portfolioflutterweb/widgets/navbar.dart';
import '../../data/projects.dart';
import 'widgets/project_hero.dart';
import 'widgets/project_overview.dart';
import 'widgets/project_features.dart';
import 'widgets/project_architecture.dart';
import 'widgets/project_snippet.dart';
import 'widgets/project_gallery.dart';

class ProjectDetailsPage extends StatelessWidget {
  final String projectId;

  const ProjectDetailsPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    final project = myProjects.firstWhere((p) => p.id == projectId);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            ProjectHero(project: project),
            ProjectOverview(project: project),
            ProjectFeatures(project: project),
            ProjectArchitecture(project: project),
            ProjectSnippet(project: project),
            ProjectGallery(project: project),
            const SizedBox(height: 60),
            Footer(),
          ],
        ),
      ),
    );
  }
}
