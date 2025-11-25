import 'package:flutter/material.dart';

class ProjectGallery extends StatelessWidget {
  final dynamic project;

  const ProjectGallery({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final images = project.images;

    if (images == null || images.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: images.map<Widget>((img) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              img,
              width: 300,
              fit: BoxFit.cover,
            ),
          );
        }).toList(),
      ),
    );
  }
}
