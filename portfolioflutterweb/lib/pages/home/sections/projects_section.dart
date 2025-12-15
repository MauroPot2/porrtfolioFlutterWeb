import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/projects.dart';
import '../../../widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle("Progetti Recenti"),
          const SizedBox(height: 30),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: myProjects.map((p) => ProjectCard(p)).toList(),
          )
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final dynamic project;
  const ProjectCard(this.project, {super.key});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = cs.brightness == Brightness.dark;

    //  Background con luminosità regolata tramite VALUES (nuovo Flutter)
    final Color cardColor = cs.surface.withValues(
      alpha: isDark ? 0.35 : 0.97,
    );

    //  Ombra dinamica con withValues()
    final Color shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.35)
        : Colors.grey.withValues(alpha: 0.25);

    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 340,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: cardColor,
          boxShadow: [
            BoxShadow(
              blurRadius: hovering ? 18 : 10,
              spreadRadius: hovering ? 2 : 1,
              color: shadowColor,
            ),
          ],
        ),

        // Contenuto della card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.project.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.project.description,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: cs.onSurface.withValues(alpha: 0.85),
              ),
            ),

            const SizedBox(height: 14),

            InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () {
                context.go('/projects');
              },
              child: Text(
                "→ Scopri di più",
                style: TextStyle(
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
