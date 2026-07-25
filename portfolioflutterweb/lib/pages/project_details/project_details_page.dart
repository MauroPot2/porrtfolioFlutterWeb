import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolioflutterweb/widgets/footer.dart';
import 'package:portfolioflutterweb/widgets/navbar.dart';

import '../../data/projects.dart';
import '../../models/project.dart';
import '../../widgets/section_container.dart';
import 'widgets/project_architecture.dart';
import 'widgets/project_features.dart';
import 'widgets/project_gallery.dart';
import 'widgets/project_hero.dart';
import 'widgets/project_overview.dart';
import 'widgets/project_snippet.dart';

class ProjectDetailsPage extends StatelessWidget {
  final String projectId;

  const ProjectDetailsPage({super.key, required this.projectId});

  Project? _findProject() {
    for (final project in myProjects) {
      if (project.id == projectId) {
        return project;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final project = _findProject();

    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Navbar(),
              if (project == null)
                const _ProjectNotFound()
              else ...[
                ProjectHero(project: project),
                ProjectOverview(project: project),
                ProjectFeatures(project: project),
                ProjectArchitecture(project: project),
                ProjectSnippet(project: project),
                ProjectGallery(project: project),
              ],
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectNotFound extends StatelessWidget {
  const _ProjectNotFound();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SectionContainer(
      minHeight: 520,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 64,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Progetto non trovato',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  height: 1.1,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Il progetto richiesto non esiste oppure il collegamento '
                'non è più disponibile.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  height: 1.6,
                  color: colorScheme.onSurface.withValues(alpha: 0.72),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => context.go('/projects'),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Torna ai progetti'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
