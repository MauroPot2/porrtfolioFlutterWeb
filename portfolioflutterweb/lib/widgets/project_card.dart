import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/project.dart';
import 'viewport_aware_image.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;
  bool _isFocused = false;

  void _openProject() {
    context.go('/projects/${widget.project.id}');
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final images = project.images ?? const <String>[];
    final previewImage = images.isEmpty ? null : images.first;
    final highlighted = _isHovered || _isFocused;

    return Semantics(
      button: true,
      label: 'Apri il caso studio ${project.title}',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedScale(
          scale: highlighted ? 1.015 : 1,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: highlighted
                    ? colorScheme.primary.withValues(alpha: 0.42)
                    : colorScheme.outline.withValues(alpha: 0.14),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: highlighted ? 26 : 14,
                  offset: Offset(0, highlighted ? 12 : 7),
                  color: Colors.black.withValues(
                    alpha: isDark ? 0.28 : 0.08,
                  ),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: _openProject,
                onFocusChange: (focused) {
                  setState(() => _isFocused = focused);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 185,
                      child: previewImage == null
                          ? _ProjectPlaceholder(
                              colorScheme: colorScheme,
                            )
                          : ColoredBox(
                              color: colorScheme.primary.withValues(
                                alpha: 0.05,
                              ),
                              child: ViewportAwareImage(
                                imagePath: previewImage,
                                width: double.infinity,
                                height: 185,
                                fit: BoxFit.cover,
                                isAsset: true,
                                preloadOffset: 250,
                                placeholder: _ProjectPlaceholder(
                                  colorScheme: colorScheme,
                                ),
                                errorWidget: _ProjectPlaceholder(
                                  colorScheme: colorScheme,
                                ),
                              ),
                            ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          22,
                          22,
                          22,
                          20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.15,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            if (project.subtitle?.trim().isNotEmpty ??
                                false) ...[
                              const SizedBox(height: 9),
                              Text(
                                project.subtitle!.trim(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                            const SizedBox(height: 14),
                            Expanded(
                              child: Text(
                                project.description,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.55,
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.72,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  'Apri il caso studio',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 19,
                                  color: colorScheme.primary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
}

class _ProjectPlaceholder extends StatelessWidget {
  final ColorScheme colorScheme;

  const _ProjectPlaceholder({
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorScheme.primary.withValues(alpha: 0.08),
      alignment: Alignment.center,
      child: Icon(
        Icons.code_rounded,
        size: 54,
        color: colorScheme.primary.withValues(alpha: 0.72),
      ),
    );
  }
}
