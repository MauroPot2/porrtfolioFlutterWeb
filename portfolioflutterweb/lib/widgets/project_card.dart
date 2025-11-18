import 'package:flutter/material.dart';
import '../models/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 350,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: hovering ? 20 : 10,
              offset: hovering ? const Offset(0, 6) : const Offset(0, 4),
              color: Colors.black12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            Text(
              project.description,
              style: const TextStyle(fontSize: 16,
              color: Colors.black54),

            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () async {
                final url = widget.project.link;
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Scopri di più",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 0, 230),
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.open_in_new, size: 18, color: Color.fromARGB(255, 255, 64, 226)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
