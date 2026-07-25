import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/widgets/photo_carousel.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const double _stackedBreakpoint = 900;

  static final Uri _cvUrl = Uri.parse(
    'https://mauropot2.github.io/porrtfolioFlutterWeb/cv.pdf',
  );

  Future<void> _openCv(BuildContext context) async {
    try {
      final opened = await launchUrl(
        _cvUrl,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && context.mounted) {
        _showLaunchError(context);
      }
    } catch (_) {
      if (context.mounted) {
        _showLaunchError(context);
      }
    }
  }

  void _showLaunchError(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Non riesco ad aprire il CV.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      maxWidth: 1240,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isStacked = constraints.maxWidth < _stackedBreakpoint;

          if (isStacked) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _AboutImage(),
                const SizedBox(height: 44),
                _AboutContent(
                  isCompact: true,
                  onOpenCv: () => _openCv(context),
                ),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(flex: 4, child: _AboutImage()),
              const SizedBox(width: 72),
              Expanded(
                flex: 6,
                child: _AboutContent(
                  isCompact: false,
                  onOpenCv: () => _openCv(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AboutImage extends StatelessWidget {
  const _AboutImage();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 380.0;
        final imageWidth = availableWidth.clamp(260.0, 400.0).toDouble();

        return Center(
          child: Semantics(
            label: 'Foto di Mauro Potestio',
            image: true,
            child: Container(
              width: imageWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: cs.outlineVariant.withValues(alpha: 0.75),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 30,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(27),
                child: PhotoCarousel(
                  width: imageWidth,
                  imagePaths: const [
                    'assets/images/about_photo.png',
                    'assets/images/about_photo_2.png',
                    'assets/images/about_photo_3.png',
                    'assets/images/about_photo_4.png',
                  ],
                  aspectRatio: 4 / 5,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AboutContent extends StatelessWidget {
  final bool isCompact;
  final VoidCallback onOpenCv;

  const _AboutContent({required this.isCompact, required this.onOpenCv});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final crossAxisAlignment = isCompact
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = isCompact ? TextAlign.center : TextAlign.left;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: cs.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: cs.primary.withValues(alpha: 0.20)),
          ),
          child: Text(
            'IL MIO PERCORSO',
            style: TextStyle(
              color: cs.primary,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Tecnologia, metodo e attenzione alle persone.',
          textAlign: textAlign,
          style: TextStyle(
            fontSize: isCompact ? 36 : 46,
            height: 1.08,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(
            'Sono Mauro Potestio, laureato in Informatica e sviluppatore '
            'Flutter. Costruisco applicazioni mobile e web partendo da '
            'esigenze concrete: prenotazioni, gestione clienti, notifiche, '
            'abbonamenti e dashboard operative.\n\n'
            'Il mio percorso professionale nasce anche dall’esperienza nel '
            'retail, dove ho imparato ad ascoltare le persone, comprendere i '
            'problemi reali e trovare soluzioni utilizzabili, non soltanto '
            'tecnicamente corrette. Porto lo stesso approccio nello sviluppo '
            'software: prima chiarisco l’obiettivo, poi progetto il flusso e '
            'infine scelgo la soluzione tecnica più adatta.\n\n'
            'Nei miei progetti seguo l’intero ciclo del prodotto, '
            'dall’interfaccia Flutter alla gestione dello stato, dalle API '
            'ai servizi cloud, fino alla pubblicazione e alla manutenzione.',
            textAlign: textAlign,
            style: TextStyle(
              fontSize: 17,
              height: 1.65,
              color: cs.onSurface.withValues(alpha: 0.78),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: isCompact ? WrapAlignment.center : WrapAlignment.start,
          children: const [
            _ApproachChip(
              icon: Icons.search_rounded,
              label: 'Analisi del problema',
            ),
            _ApproachChip(
              icon: Icons.account_tree_outlined,
              label: 'Architettura pulita',
            ),
            _ApproachChip(icon: Icons.devices_rounded, label: 'UI responsive'),
            _ApproachChip(icon: Icons.cloud_outlined, label: 'Servizi cloud'),
          ],
        ),
        const SizedBox(height: 38),
        ElevatedButton.icon(
          onPressed: onOpenCv,
          icon: const Icon(Icons.open_in_new_rounded, size: 20),
          label: const Text('Apri il mio CV'),
          style: ElevatedButton.styleFrom(
            backgroundColor: cs.primary,
            foregroundColor: cs.onPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 17),
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
    );
  }
}

class _ApproachChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ApproachChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: cs.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: cs.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
