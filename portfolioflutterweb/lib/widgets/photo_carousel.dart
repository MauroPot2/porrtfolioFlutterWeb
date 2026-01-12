import 'package:flutter/material.dart';

class PhotoCarousel extends StatefulWidget {
  final List<String> imagePaths;
  final double width;
  final double aspectRatio; // es. 1 = quadrato, 4/5 ecc.

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int i) {
    if (i < 0 || i >= widget.imagePaths.length) return;
    _controller.animateToPage(
      i,
      duration: const Duration(milliseconds: 125),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.imagePaths.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Box immagine (con frecce)
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: count,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) {
                    return Image.asset(
                      widget.imagePaths[i],
                      fit: BoxFit.cover,
                      width: widget.width,
                    );
                  },
                ),

                // Freccia sinistra
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _NavButton(
                      icon: Icons.chevron_left,
                      onTap: _index > 0 ? () => _goTo(_index - 1) : null,
                    ),
                  ),
                ),

                // Freccia destra
                Positioned(
                  right: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _NavButton(
                      icon: Icons.chevron_right,
                      onTap: _index < count - 1 ? () => _goTo(_index + 1) : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Indicatori
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(count, (i) {
            final selected = i == _index;
            return GestureDetector(
              onTap: () => _goTo(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: selected ? 10 : 7,
                height: selected ? 10 : 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.35),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Material(
      color: Colors.black.withOpacity(enabled ? 0.35 : 0.15),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 28,
            color: Colors.white.withOpacity(enabled ? 1 : 0.4),
          ),
        ),
      ),
    );
  }
}
