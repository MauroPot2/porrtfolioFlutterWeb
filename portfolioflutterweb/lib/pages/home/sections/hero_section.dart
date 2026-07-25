import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolioflutterweb/widgets/photo_carousel.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  static const double _stackedBreakpoint = 900;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      maxWidth: 1280,
      minHeight: 620,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isStacked = constraints.maxWidth < _stackedBreakpoint;

          if (isStacked) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _HeroContent(isCompact: true),
                const SizedBox(height: 52),
                const _HeroVisual(),
              ],
            );
          }

          return const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 6, child: _HeroContent(isCompact: false)),
              SizedBox(width: 64),
              Expanded(flex: 5, child: _HeroVisual()),
            ],
          );
        },
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final bool isCompact;

  const _HeroContent({required this.isCompact});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final alignment = isCompact
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = isCompact ? TextAlign.center : TextAlign.left;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: cs.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: cs.primary.withValues(alpha: 0.20)),
          ),
          child: Text(
            'FLUTTER DEVELOPER • MOBILE & WEB',
            style: TextStyle(
              color: cs.primary,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 24),
        AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'Trasformo idee in\nprodotti digitali.',
              textStyle: TextStyle(
                fontSize: isCompact ? 42 : 62,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.6,
                color: cs.onSurface,
                height: 1.05,
              ),
              textAlign: textAlign,
              speed: const Duration(milliseconds: 45),
            ),
          ],
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            'Sviluppo applicazioni Flutter e piattaforme web, seguendo il '
            'progetto dall’interfaccia alle API, fino alla pubblicazione e '
            'alla crescita del prodotto.',
            style: TextStyle(
              fontSize: isCompact ? 18 : 21,
              color: cs.onSurface.withValues(alpha: 0.72),
              height: 1.55,
            ),
            textAlign: textAlign,
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: isCompact ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () => context.go('/projects'),
              icon: const Icon(Icons.grid_view_rounded, size: 20),
              label: const Text('Guarda i progetti'),
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 19,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/contact'),
              icon: const Icon(Icons.arrow_forward_rounded, size: 20),
              label: const Text('Contattami'),
              style: OutlinedButton.styleFrom(
                foregroundColor: cs.onSurface,
                side: BorderSide(color: cs.outlineVariant),
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 19,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final carouselWidth = constraints.maxWidth > 520
            ? 520.0
            : constraints.maxWidth;

        return Center(
          child: Container(
            width: carouselWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: cs.outlineVariant.withValues(alpha: 0.7),
              ),
              boxShadow: [
                BoxShadow(
                  color: cs.primary.withValues(alpha: 0.16),
                  blurRadius: 42,
                  spreadRadius: 2,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: PhotoCarousel(
                width: carouselWidth,
                aspectRatio: 16 / 10,
                imagePaths: const [
                  'assets/projects/shavette_1.png',
                  'assets/projects/ponte_1.png',
                  'assets/projects/cicloverso_1.png',
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
