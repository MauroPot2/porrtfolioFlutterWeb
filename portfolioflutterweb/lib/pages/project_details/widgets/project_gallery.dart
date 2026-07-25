import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/models/project.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';
import 'package:portfolioflutterweb/widgets/viewport_aware_image.dart';

class ProjectGallery extends StatelessWidget {
  final Project project;

  const ProjectGallery({super.key, required this.project});

  void _openImage(BuildContext context, String imagePath) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final colorScheme = Theme.of(dialogContext).colorScheme;

        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          backgroundColor: colorScheme.surface,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: 1100,
            height: 720,
            child: Stack(
              children: [
                Positioned.fill(
                  child: InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 4,
                    child: Center(
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Text(
                                'Impossibile caricare questa immagine.',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton.filled(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    tooltip: 'Chiudi',
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = project.images ?? const <String>[];

    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return SectionContainer(
      maxWidth: 1100,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Galleria',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Seleziona un’immagine per visualizzarla a schermo intero.',
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurface.withValues(alpha: 0.68),
            ),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 20.0;
              final columns = constraints.maxWidth < 760 ? 1 : 2;
              final imageWidth =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: images.map((imagePath) {
                  return Semantics(
                    button: true,
                    label: 'Apri immagine del progetto ${project.title}',
                    child: SizedBox(
                      width: imageWidth,
                      child: Material(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(18),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => _openImage(context, imagePath),
                          child: AspectRatio(
                            aspectRatio: 16 / 10,
                            child: ViewportAwareImage(
                              imagePath: imagePath,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.contain,
                              isAsset: true,
                              preloadOffset: 200,
                              errorWidget: Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.50,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
