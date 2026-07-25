import 'package:flutter/material.dart';

import 'viewport_aware_image.dart';

class PhotoCarousel extends StatefulWidget {
  final List<String> imagePaths;
  final double width;
  final double aspectRatio;

  const PhotoCarousel({
    super.key,
    required this.imagePaths,
    required this.width,
    this.aspectRatio = 4 / 5,
  });

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void didUpdateWidget(covariant PhotoCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.imagePaths.isEmpty) {
      _index = 0;
      return;
    }

    final lastIndex = widget.imagePaths.length - 1;

    if (_index > lastIndex) {
      _index = lastIndex;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _controller.hasClients) {
          _controller.jumpToPage(_index);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _goTo(int index) async {
    if (index < 0 ||
        index >= widget.imagePaths.length ||
        !_controller.hasClients) {
      return;
    }

    await _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final count = widget.imagePaths.length;

    if (count == 0) {
      return SizedBox(
        width: widget.width,
        child: AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(
                Icons.photo_library_outlined,
                size: 48,
                color: colorScheme.primary.withValues(alpha: 0.62),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: widget.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: widget.aspectRatio,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    controller: _controller,
                    itemCount: count,
                    onPageChanged: (index) {
                      setState(() => _index = index);
                    },
                    itemBuilder: (context, index) {
                      return ViewportAwareImage(
                        imagePath: widget.imagePaths[index],
                        fit: BoxFit.cover,
                        width: widget.width,
                        isAsset: true,
                        preloadOffset: 180,
                      );
                    },
                  ),
                  if (count > 1) ...[
                    Positioned(
                      left: 10,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: _NavButton(
                          tooltip: 'Immagine precedente',
                          icon: Icons.chevron_left_rounded,
                          onTap: _index > 0
                              ? () => _goTo(_index - 1)
                              : null,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: _NavButton(
                          tooltip: 'Immagine successiva',
                          icon: Icons.chevron_right_rounded,
                          onTap: _index < count - 1
                              ? () => _goTo(_index + 1)
                              : null,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (count > 1) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: List.generate(count, (index) {
                final selected = index == _index;

                return Semantics(
                  button: true,
                  selected: selected,
                  label: 'Vai all’immagine ${index + 1} di $count',
                  child: Tooltip(
                    message: 'Immagine ${index + 1}',
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => _goTo(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: selected ? 11 : 8,
                        height: selected ? 11 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected
                              ? colorScheme.primary
                              : colorScheme.primary.withValues(alpha: 0.30),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  const _NavButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.black.withValues(
          alpha: enabled ? 0.48 : 0.20,
        ),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 28,
              color: Colors.white.withValues(
                alpha: enabled ? 0.96 : 0.36,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
