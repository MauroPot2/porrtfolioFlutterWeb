import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolioflutterweb/data/projects.dart';
import 'package:portfolioflutterweb/models/project.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';
import 'package:portfolioflutterweb/widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Casi studio'),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Text(
              'Progetti reali nei quali ho affrontato interfacce, dati, '
              'autenticazione, automazioni e distribuzione del prodotto.',
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
              final columns = _columnsForWidth(constraints.maxWidth);
              final cardWidth =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final project in myProjects)
                    ProjectCard(project: project, width: cardWidth),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  int _columnsForWidth(double width) {
    if (width >= 1050) return 3;
    if (width >= 680) return 2;
    return 1;
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;
  final double width;

  const ProjectCard({required this.project, required this.width, super.key});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final project = widget.project;
    final subtitle = project.subtitle?.trim();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Semantics(
        button: true,
        label: 'Apri il caso studio ${project.title}',
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: widget.width,
          transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? cs.primary.withValues(alpha: 0.45)
                  : cs.outlineVariant.withValues(alpha: 0.75),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.13 : 0.07),
                blurRadius: _isHovered ? 24 : 14,
                offset: Offset(0, _isHovered ? 12 : 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => context.go('/projects/${project.id}'),
              child: Padding(
                padding: const EdgeInsets.all(26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: 0.11),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        _iconForProject(project.id),
                        color: cs.primary,
                        size: 27,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      project.title,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: cs.onSurface,
                        height: 1.2,
                      ),
                    ),
                    if (subtitle != null && subtitle.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: cs.primary,
                          height: 1.4,
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    Text(
                      project.description,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.55,
                        color: cs.onSurface.withValues(alpha: 0.74),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Apri il caso studio',
                          style: TextStyle(
                            color: cs.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: cs.primary,
                          size: 19,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconForProject(String id) {
    switch (id.toLowerCase()) {
      case 'cicloverso':
        return Icons.pedal_bike_rounded;
      case 'fantanews':
        return Icons.newspaper_rounded;
      case 'shavette':
        return Icons.content_cut_rounded;
      case 'ponte':
        return Icons.restaurant_rounded;
      case 'portfolio':
        return Icons.web_rounded;
      default:
        return Icons.apps_rounded;
    }
  }
}
