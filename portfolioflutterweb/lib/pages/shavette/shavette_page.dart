import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/pages/shavette/widgets/founding_salon_form.dart';
import 'package:url_launcher/url_launcher.dart';

const _navy = Color(0xFF111B43);
const _blue = Color(0xFF2F80ED);
const _muted = Color(0xFF5E6A82);
const _softBackground = Color(0xFFF5F8FF);
const _appStoreUrl = 'https://apps.apple.com/it/app/shavette/id6771834454';
const _privacyPolicyUrl =
    'https://docs.google.com/document/d/e/'
    '2PACX-1vQIY9lynkZMX9JqLDklxBqGL1sYw7JAzVOU5Gj9d6tsX8EHhLtMzVCT4RFvh2j_'
    'O4CJEwYpDqECa0hC/pub';

class ShavettePage extends StatefulWidget {
  const ShavettePage({super.key});

  @override
  State<ShavettePage> createState() => _ShavettePageState();
}

class _ShavettePageState extends State<ShavettePage> {
  final _featuresKey = GlobalKey();
  final _formSectionKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final targetContext = key.currentContext;
    if (targetContext == null) return;

    await Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 620),
      curve: Curves.easeOutCubic,
      alignment: 0.04,
    );
  }

  Future<void> _openUrl(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Shavette Founding Salons | MauroPot',
      color: _blue,
      child: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: _blue,
            brightness: Brightness.light,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: _blue,
            selectionColor: Color(0x443D8EF5),
            selectionHandleColor: _blue,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SelectionArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _LandingHeader(onApply: () => _scrollTo(_formSectionKey)),
                  _HeroSection(
                    onApply: () => _scrollTo(_formSectionKey),
                    onDiscover: () => _scrollTo(_featuresKey),
                    onOpenAppStore: () => _openUrl(_appStoreUrl),
                  ),
                  KeyedSubtree(
                    key: _featuresKey,
                    child: const _FeaturesSection(),
                  ),
                  const _OfferSection(),
                  KeyedSubtree(
                    key: _formSectionKey,
                    child: const _ApplicationSection(),
                  ),
                  _LandingFooter(
                    onOpenPrivacy: () => _openUrl(_privacyPolicyUrl),
                    onOpenAppStore: () => _openUrl(_appStoreUrl),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LandingHeader extends StatelessWidget {
  const _LandingHeader({required this.onApply});

  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white.withValues(alpha: 0.98),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.asset(
                  'assets/images/shavette/shavette_icon.jpg',
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  semanticLabel: 'Icona dell’app Shavette',
                ),
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shavette',
                      style: TextStyle(
                        color: _navy,
                        fontSize: 19,
                        height: 1.05,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.35,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'FOUNDING SALONS',
                      style: TextStyle(
                        color: _blue,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final compact = MediaQuery.sizeOf(context).width < 540;

                  return FilledButton(
                    onPressed: onApply,
                    style: FilledButton.styleFrom(
                      backgroundColor: _navy,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: compact ? 15 : 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    child: Text(compact ? 'CANDIDATI' : 'CANDIDA IL SALONE'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.onApply,
    required this.onDiscover,
    required this.onOpenAppStore,
  });

  final VoidCallback onApply;
  final VoidCallback onDiscover;
  final VoidCallback onOpenAppStore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF7FAFF), Color(0xFFEAF2FF)],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 900;
              final horizontalPadding = constraints.maxWidth < 600
                  ? 20.0
                  : 42.0;
              final copy = _HeroCopy(onApply: onApply, onDiscover: onDiscover);
              final visual = _HeroVisual(onOpenAppStore: onOpenAppStore);

              return Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  stacked ? 54 : 72,
                  horizontalPadding,
                  stacked ? 64 : 76,
                ),
                child: stacked
                    ? Column(
                        children: [copy, const SizedBox(height: 48), visual],
                      )
                    : Row(
                        children: [
                          Expanded(flex: 11, child: copy),
                          const SizedBox(width: 72),
                          Expanded(flex: 7, child: visual),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.onApply, required this.onDiscover});

  final VoidCallback onApply;
  final VoidCallback onDiscover;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE1EDFF),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFFBFD6FA)),
          ),
          child: const Text(
            'SHAVETTE FOUNDING SALONS · 20 POSTI',
            style: TextStyle(
              color: Color(0xFF1D67CC),
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 23),
        Text(
          'Cerchiamo i primi 20 saloni.',
          style: TextStyle(
            color: _navy,
            fontSize: compact ? 43 : 60,
            height: 1.02,
            fontWeight: FontWeight.w900,
            letterSpacing: compact ? -1.5 : -2.5,
          ),
        ),
        const SizedBox(height: 22),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Shavette Pro completo '),
              TextSpan(
                text: 'gratis',
                style: TextStyle(color: _blue, fontWeight: FontWeight.w800),
              ),
              const TextSpan(text: ' fino al 31 dicembre 2026.'),
            ],
          ),
          style: TextStyle(
            color: _navy.withValues(alpha: 0.88),
            fontSize: compact ? 21 : 24,
            height: 1.35,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.35,
          ),
        ),
        const SizedBox(height: 18),
        const Wrap(
          spacing: 10,
          runSpacing: 9,
          children: [
            _TrustChip(
              icon: Icons.credit_card_off_outlined,
              label: 'Nessuna carta richiesta',
            ),
            _TrustChip(
              icon: Icons.autorenew_rounded,
              label: 'Nessun rinnovo automatico',
            ),
          ],
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: onApply,
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text('CANDIDA IL TUO SALONE'),
              style: FilledButton.styleFrom(
                backgroundColor: _blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 23,
                  vertical: 19,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.25,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: onDiscover,
              style: OutlinedButton.styleFrom(
                foregroundColor: _navy,
                side: const BorderSide(color: Color(0xFFBBC9E0)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 21,
                  vertical: 19,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              child: const Text('Scopri Shavette'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified_rounded, size: 18, color: Color(0xFF128455)),
            SizedBox(width: 7),
            Flexible(
              child: Text(
                'Programma per early adopter reali, non una trial mascherata.',
                style: TextStyle(
                  color: _muted,
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
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
  const _HeroVisual({required this.onOpenAppStore});

  final VoidCallback onOpenAppStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 410),
          child: Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: const Color(0xFFD8E4F6)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26245697),
                  blurRadius: 44,
                  offset: Offset(0, 24),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/shavette/shavette_agenda.jpg',
                fit: BoxFit.cover,
                semanticLabel:
                    'Screenshot reale di Shavette con l’agenda del salone',
              ),
            ),
          ),
        ),
        const SizedBox(height: 17),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            const Text(
              'Screenshot reale dell’app',
              style: TextStyle(
                color: _muted,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: onOpenAppStore,
              child: const Text('Vedi su App Store'),
            ),
          ],
        ),
      ],
    );
  }
}

class _TrustChip extends StatelessWidget {
  const _TrustChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFD7E2F2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: _blue),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF46526B),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  static const _features = [
    (Icons.calendar_month_outlined, 'Prenotazioni online'),
    (Icons.people_alt_outlined, 'Gestione clienti'),
    (Icons.content_cut_rounded, 'Servizi e staff'),
    (Icons.notifications_active_outlined, 'Promemoria automatici'),
    (Icons.space_dashboard_outlined, 'Gestione del salone'),
    (Icons.phone_iphone_rounded, 'App cliente e barbiere'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 88),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              const _SectionEyebrow('TUTTO IN UN UNICO POSTO'),
              const SizedBox(height: 12),
              const Text(
                'Meno messaggi. Più tempo per il tuo salone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _navy,
                  fontSize: 38,
                  height: 1.12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.2,
                ),
              ),
              const SizedBox(height: 14),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: const Text(
                  'Shavette riunisce l’organizzazione quotidiana del salone '
                  'in un’esperienza semplice per te, il tuo staff e i clienti.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _muted, fontSize: 17, height: 1.55),
                ),
              ),
              const SizedBox(height: 38),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 900
                      ? 3
                      : constraints.maxWidth >= 560
                      ? 2
                      : 1;
                  const gap = 16.0;
                  final cardWidth =
                      (constraints.maxWidth - gap * (columns - 1)) / columns;

                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: [
                      for (final feature in _features)
                        SizedBox(
                          width: cardWidth,
                          child: _FeatureCard(
                            icon: feature.$1,
                            label: feature.$2,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 116),
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: _softBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E8F5)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x102F80ED),
                  blurRadius: 12,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: _blue, size: 25),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _navy,
                fontSize: 17,
                height: 1.25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferSection extends StatelessWidget {
  const _OfferSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _navy,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 88),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 820;
              final heading = const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionEyebrow('L’OFFERTA', color: Color(0xFF8DB9FA)),
                  SizedBox(height: 13),
                  Text(
                    'Cosa significa Founding Salon?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      height: 1.1,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.25,
                    ),
                  ),
                  SizedBox(height: 17),
                  Text(
                    'Un rapporto diretto con i primi saloni che useranno '
                    'Shavette sul campo e contribuiranno a renderla migliore.',
                    style: TextStyle(
                      color: Color(0xFFC7D2E8),
                      fontSize: 17,
                      height: 1.58,
                    ),
                  ),
                ],
              );
              final offer = const _OfferCard();

              if (stacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [heading, SizedBox(height: 34), offer],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 5, child: SizedBox(child: heading)),
                  const SizedBox(width: 70),
                  Expanded(flex: 6, child: offer),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2858),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF334579)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.format_quote_rounded, color: Color(0xFF8DB9FA), size: 38),
          SizedBox(height: 12),
          Text(
            'I primi 20 saloni selezionati potranno utilizzare tutte le '
            'funzionalità Pro di Shavette gratuitamente fino al 31 dicembre '
            '2026.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              height: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 18),
          Divider(color: Color(0xFF3A4B7E)),
          SizedBox(height: 18),
          Text(
            'In cambio ti chiederemo semplicemente di utilizzare Shavette '
            'realmente nel tuo salone e raccontarci cosa possiamo migliorare.',
            style: TextStyle(
              color: Color(0xFFD6DEEE),
              fontSize: 17,
              height: 1.55,
            ),
          ),
          SizedBox(height: 22),
          _OfferAssurance(
            icon: Icons.handshake_outlined,
            text: 'Early adopter, non prova gratuita',
          ),
          SizedBox(height: 11),
          _OfferAssurance(
            icon: Icons.payments_outlined,
            text: 'Zero costi e zero rinnovi automatici',
          ),
        ],
      ),
    );
  }
}

class _OfferAssurance extends StatelessWidget {
  const _OfferAssurance({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF8DB9FA)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFE7ECF6),
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _ApplicationSection extends StatelessWidget {
  const _ApplicationSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _softBackground,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 88),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              const _SectionEyebrow('CANDIDATURE APERTE'),
              const SizedBox(height: 12),
              const Text(
                'Porta il tuo salone tra i primi 20.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _navy,
                  fontSize: 40,
                  height: 1.1,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.2,
                ),
              ),
              const SizedBox(height: 14),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: const Text(
                  'Compila il modulo: valuteremo personalmente ogni '
                  'candidatura e ti contatteremo all’indirizzo indicato.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _muted, fontSize: 17, height: 1.55),
                ),
              ),
              const SizedBox(height: 40),
              const FoundingSalonForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionEyebrow extends StatelessWidget {
  const _SectionEyebrow(this.text, {this.color = _blue});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.55,
      ),
    );
  }
}

class _LandingFooter extends StatelessWidget {
  const _LandingFooter({
    required this.onOpenPrivacy,
    required this.onOpenAppStore,
  });

  final VoidCallback onOpenPrivacy;
  final VoidCallback onOpenAppStore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 26,
            runSpacing: 16,
            children: [
              const Text(
                '© 2026 Shavette · Un progetto MauroPot',
                style: TextStyle(
                  color: _muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Wrap(
                spacing: 4,
                children: [
                  TextButton(
                    onPressed: onOpenAppStore,
                    child: const Text('App Store'),
                  ),
                  TextButton(
                    onPressed: onOpenPrivacy,
                    child: const Text('Privacy'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
