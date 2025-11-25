import 'package:flutter/material.dart';

class ProjectFeatures extends StatelessWidget {
  final dynamic project;

  const ProjectFeatures({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (project.features == null || project.features!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Caratteristiche Principali",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          ...project.features!.map((f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 20, color: cs.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        f,
                        style: TextStyle(
                          fontSize: 16,
                          color: cs.onSurface.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
