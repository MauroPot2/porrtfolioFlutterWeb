import 'package:flutter/material.dart';
import '../../../widgets/viewport_aware_image.dart';

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
            child: ViewportAwareImage(
              imagePath: img,
              width: 300,
              fit: BoxFit.cover,
              isAsset: true,
              preloadOffset: 150.0, // Carica quando è a 150px dal viewport
            ),
          );
        }).toList(),
      ),
    );
  }
}
