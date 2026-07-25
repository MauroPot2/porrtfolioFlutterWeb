import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';
import 'package:portfolioflutterweb/widgets/section_title.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static const _services = [
    _ServiceData(
      icon: Icons.phone_iphone_rounded,
      title: 'Flutter, iOS e Android',
      description:
          'Creo interfacce responsive e applicazioni cross-platform con '
          'Flutter, Dart, Material 3, Riverpod e GoRouter.',
    ),
    _ServiceData(
      icon: Icons.dns_rounded,
      title: 'Backend, dati e integrazioni',
      description:
          'Collego app e servizi tramite Firebase, Firestore, Supabase, '
          'API REST e backend Python, gestendo autenticazione e dati reali.',
    ),
    _ServiceData(
      icon: Icons.rocket_launch_rounded,
      title: 'Qualità e rilascio',
      description:
          'Organizzo il codice con architetture manutenibili, versionamento '
          'Git, automazioni CI/CD e attenzione alla pubblicazione sugli store.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SectionContainer(
      color: cs.surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Cosa porto in un progetto'),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Text(
              'Non mi fermo alla schermata: costruisco il flusso completo, '
              'dall’esperienza utente ai dati e al rilascio.',
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
                color: cs.onSurface.withValues(alpha: 0.70),
              ),
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 24.0;
              final columns = _columnsForWidth(constraints.maxWidth);
              final cardWidth =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final service in _services)
                    _ServiceCard(data: service, width: cardWidth),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  int _columnsForWidth(double width) {
    if (width >= 1000) return 3;
    if (width >= 650) return 2;
    return 1;
  }
}

class _ServiceData {
  final IconData icon;
  final String title;
  final String description;

  const _ServiceData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _ServiceCard extends StatefulWidget {
  final _ServiceData data;
  final double width;

  const _ServiceCard({required this.data, required this.width});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: widget.width,
        transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? cs.primary.withValues(alpha: 0.45)
                : cs.outlineVariant.withValues(alpha: 0.75),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.12 : 0.06),
              blurRadius: _isHovered ? 22 : 12,
              offset: Offset(0, _isHovered ? 10 : 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.11),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(widget.data.icon, size: 29, color: cs.primary),
            ),
            const SizedBox(height: 22),
            Text(
              widget.data.title,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                height: 1.2,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.data.description,
              style: TextStyle(
                fontSize: 15,
                height: 1.55,
                color: cs.onSurface.withValues(alpha: 0.74),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
