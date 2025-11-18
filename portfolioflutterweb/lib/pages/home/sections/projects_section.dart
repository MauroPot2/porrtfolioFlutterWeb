import 'package:flutter/material.dart';
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
            children: myProjects.map((p) => _ProjectCard(p)).toList(),
          )
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final dynamic project;
  const _ProjectCard(this.project);

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 340,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 0, 0, 0),
          boxShadow: [
            BoxShadow(
              blurRadius: hovering ? 20 : 10,
              color: Colors.black12,
              spreadRadius: hovering ? 2 : 1,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.project.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(widget.project.description),
            const SizedBox(height: 14),
            InkWell(
              onTap: () {},
              child: const Text(
                "→ Scopri di più",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 5, 230),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
