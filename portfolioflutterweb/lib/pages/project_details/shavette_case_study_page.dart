import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/footer.dart';
import '../../widgets/navbar.dart';

class ShavetteCaseStudyPage extends StatelessWidget {
  const ShavetteCaseStudyPage({super.key});

  static final Uri _productUri = Uri.parse('https://mauropot.com/shavette');
  static final Uri _linkedinUri = Uri.parse(
    'https://www.linkedin.com/in/mauroleonardo-potestio/',
  );
  static final Uri _mailUri = Uri(
    scheme: 'mailto',
    path: 'mauroleonardo.potestio@gmail.com',
    queryParameters: {
      'subject': 'Contatto dal case study Shavette',
    },
  );

  Future<void> _open(Uri uri) async {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Navbar(),
              _Hero(
                onProductTap: () => _open(_productUri),
                onLinkedInTap: () => _open(_linkedinUri),
              ),
              const _CaseStudyIntro(),
              const _WhatIBuilt(),
              const _ArchitectureSection(),
              const _EngineeringChallenges(),
              const _ProductThinking(),
              const _EvidenceSection(),
              _FinalCta(
                onLinkedInTap: () => _open(_linkedinUri),
                onEmailTap: () => _open(_mailUri),
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final VoidCallback onProductTap;
  final VoidCallback onLinkedInTap;

  const _Hero({
    required this.onProductTap,
    required this.onLinkedInTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF121827),
            Color(0xFF171D31),
            Color(0xFF241B32),
          ],
        ),
      ),
      child: _PageWidth(
        padding: const EdgeInsets.symmetric(vertical: 72),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 860;

            final copy = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [
                    _HeroBadge('PRODUCT CASE STUDY'),
                    _HeroBadge('REPOSITORY PRIVATE'),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Shavette',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 58,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2.2,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Da idea a prodotto: booking, backend serverless, notifiche, subscription e release engineering.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: 22,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Un case study tecnico sul prodotto che uso per dimostrare come affronto problemi reali di sviluppo Flutter: architettura, dati, autenticazione, permessi, backend, monetizzazione e distribuzione.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.66),
                    fontSize: 16,
                    height: 1.65,
                  ),
                ),
                const SizedBox(height: 26),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _TechChip('Flutter'),
                    _TechChip('Dart'),
                    _TechChip('Riverpod'),
                    _TechChip('Firebase Auth'),
                    _TechChip('Cloud Firestore'),
                    _TechChip('Cloud Functions'),
                    _TechChip('FCM'),
                    _TechChip('RevenueCat'),
                  ],
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: onProductTap,
                      icon: const Icon(Icons.open_in_new_rounded),
                      label: const Text('Vedi il prodotto'),
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 18,
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: onLinkedInTap,
                      icon: const Icon(Icons.person_outline_rounded),
                      label: const Text('Profilo LinkedIn'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );

            final visual = Container(
              constraints: const BoxConstraints(maxWidth: 390),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.11),
                ),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: AspectRatio(
                      aspectRatio: 1.6,
                      child: Image.asset(
                        'assets/images/shavette/shavette_agenda.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Row(
                    children: [
                      Expanded(
                        child: _Metric(
                          value: '2',
                          label: 'flavor mobile',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _Metric(
                          value: 'E2E',
                          label: 'ownership',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        child: _Metric(
                          value: 'Cloud',
                          label: 'backend',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _Metric(
                          value: 'iOS + Android',
                          label: 'release target',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  copy,
                  const SizedBox(height: 42),
                  Center(child: visual),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: copy),
                const SizedBox(width: 54),
                Expanded(flex: 4, child: visual),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CaseStudyIntro extends StatelessWidget {
  const _CaseStudyIntro();

  @override
  Widget build(BuildContext context) {
    return const _Section(
      eyebrow: '01 · CONTESTO',
      title: 'Non una demo: un prodotto con vincoli reali',
      intro:
          'Shavette nasce come piattaforma di prenotazione per barber shop e saloni. Il progetto mi ha portato oltre la UI: ho dovuto progettare flussi, ruoli, dati, backend, notifiche, acquisti e distribuzione, gestendo anche i vincoli imposti dagli store.',
      child: _GridCards(
        children: [
          _InfoCard(
            icon: Icons.groups_2_outlined,
            title: 'Due tipologie di utente',
            body:
                'Cliente e professionista condividono lo stesso ecosistema, ma con flussi, permessi e obiettivi diversi.',
          ),
          _InfoCard(
            icon: Icons.event_available_outlined,
            title: 'Booking come dominio centrale',
            body:
                'Disponibilità, servizi, staff, chiusure, agenda e reminder devono rimanere coerenti nello stesso modello dati.',
          ),
          _InfoCard(
            icon: Icons.storefront_outlined,
            title: 'White-label reale',
            body:
                'Il progetto usa flavor distinti per produrre applicazioni brandizzate partendo dalla stessa codebase.',
          ),
        ],
      ),
    );
  }
}

class _WhatIBuilt extends StatelessWidget {
  const _WhatIBuilt();

  @override
  Widget build(BuildContext context) {
    return const _Section(
      tone: _SectionTone.soft,
      eyebrow: '02 · COSA HO COSTRUITO',
      title: 'Responsabilità end-to-end',
      intro:
          'Il valore del progetto non è una singola feature, ma l’insieme di decisioni necessarie per trasformare una codebase Flutter in un prodotto utilizzabile e distribuibile.',
      child: _GridCards(
        children: [
          _InfoCard(
            icon: Icons.phone_iphone_rounded,
            title: 'Applicazione Flutter',
            body:
                'UI responsive, navigazione, state management con Riverpod e separazione delle responsabilità per feature.',
          ),
          _InfoCard(
            icon: Icons.lock_outline_rounded,
            title: 'Auth, ruoli e permessi',
            body:
                'Firebase Authentication, accesso salon/staff e logiche che distinguono owner, collaboratori e utenti finali.',
          ),
          _InfoCard(
            icon: Icons.cloud_queue_rounded,
            title: 'Backend serverless',
            body:
                'Cloud Functions e Firestore per disponibilità, prenotazioni, gestione staff, comunicazioni e operazioni sensibili.',
          ),
          _InfoCard(
            icon: Icons.notifications_active_outlined,
            title: 'Push e reminder',
            body:
                'Firebase Cloud Messaging e notifiche locali per eventi applicativi e promemoria legati agli appuntamenti.',
          ),
          _InfoCard(
            icon: Icons.workspace_premium_outlined,
            title: 'Subscription',
            body:
                'RevenueCat per la gestione degli entitlement e dei flussi di abbonamento tra Android e iOS.',
          ),
          _InfoCard(
            icon: Icons.rocket_launch_outlined,
            title: 'Build & release',
            body:
                'Flavor, versioning, configurazioni per piattaforma e gestione delle richieste di review degli store.',
          ),
        ],
      ),
    );
  }
}

class _ArchitectureSection extends StatelessWidget {
  const _ArchitectureSection();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _Section(
      eyebrow: '03 · ARCHITETTURA',
      title: 'Una pipeline semplice da leggere, ma con responsabilità separate',
      intro:
          'L’obiettivo architetturale è mantenere UI, stato, accesso ai dati e logica server separati abbastanza da poter evolvere il prodotto senza concentrare tutto nei widget.',
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 760;
              final items = const [
                _ArchitectureNode(
                  icon: Icons.widgets_outlined,
                  title: 'Presentation',
                  body: 'Flutter UI · GoRouter',
                ),
                _ArchitectureNode(
                  icon: Icons.account_tree_outlined,
                  title: 'State & domain',
                  body: 'Riverpod · models',
                ),
                _ArchitectureNode(
                  icon: Icons.storage_outlined,
                  title: 'Data layer',
                  body: 'Firestore · repositories',
                ),
                _ArchitectureNode(
                  icon: Icons.cloud_outlined,
                  title: 'Server',
                  body: 'Cloud Functions · Node.js',
                ),
              ];

              if (compact) {
                return Column(
                  children: [
                    for (var i = 0; i < items.length; i++) ...[
                      items[i],
                      if (i != items.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Icon(
                            Icons.arrow_downward_rounded,
                            color: scheme.primary,
                          ),
                        ),
                    ],
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    Expanded(child: items[i]),
                    if (i != items.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: scheme.primary,
                        ),
                      ),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: const Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _OutlineChip('Firebase Authentication'),
                _OutlineChip('Cloud Firestore'),
                _OutlineChip('Cloud Functions'),
                _OutlineChip('Firebase Messaging'),
                _OutlineChip('Google Sign-In'),
                _OutlineChip('Sign in with Apple'),
                _OutlineChip('RevenueCat'),
                _OutlineChip('Flutter flavors'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EngineeringChallenges extends StatelessWidget {
  const _EngineeringChallenges();

  @override
  Widget build(BuildContext context) {
    return const _Section(
      tone: _SectionTone.soft,
      eyebrow: '04 · ENGINEERING CHALLENGES',
      title: 'Problemi che non compaiono nei tutorial',
      intro:
          'Le parti più formative sono state quelle in cui il problema non era “scrivere un widget”, ma far convivere sicurezza, asincronia, business logic e vincoli esterni.',
      child: _ChallengeList(
        items: [
          _Challenge(
            number: '01',
            title: 'Accesso multi-ruolo senza allargare troppo i permessi',
            body:
                'Ho separato le responsabilità tra owner e staff, con controlli lato backend e test dedicati sulle regole di accesso.',
          ),
          _Challenge(
            number: '02',
            title: 'Reminder affidabili legati agli appuntamenti',
            body:
                'I promemoria richiedono sincronizzazione tra dati Firestore, scheduling server-side, token FCM e comportamento locale del dispositivo.',
          ),
          _Challenge(
            number: '03',
            title: 'Subscription coerenti tra app e backend',
            body:
                'La UI non può essere l’unica fonte di verità: gli entitlement RevenueCat devono essere gestiti in modo coerente con lo stato applicativo.',
          ),
          _Challenge(
            number: '04',
            title: 'Una codebase, più brand',
            body:
                'Flavor e configurazioni separate permettono di cambiare bundle, icone e identità mantenendo condivisa la logica principale.',
          ),
        ],
      ),
    );
  }
}

class _ProductThinking extends StatelessWidget {
  const _ProductThinking();

  @override
  Widget build(BuildContext context) {
    return const _Section(
      eyebrow: '05 · PRODUCT THINKING',
      title: 'Sviluppare anche intorno al codice',
      intro:
          'Shavette mi ha costretto a trattare lo sviluppo come parte di un prodotto: costi cloud, onboarding, privacy, distribuzione, affidabilità e semplicità d’uso hanno conseguenze tecniche concrete.',
      child: _GridCards(
        children: [
          _InfoCard(
            icon: Icons.price_check_outlined,
            title: 'Cost awareness',
            body:
                'Query, Functions e notifiche vengono progettate tenendo presente il consumo delle risorse Firebase.',
          ),
          _InfoCard(
            icon: Icons.verified_user_outlined,
            title: 'Store compliance',
            body:
                'Privacy, guest access, acquisti in-app e account deletion influenzano direttamente i flussi applicativi.',
          ),
          _InfoCard(
            icon: Icons.monitor_heart_outlined,
            title: 'Production mindset',
            body:
                'Bug, test, deploy e reminder vengono trattati come problemi di affidabilità del prodotto, non solo di interfaccia.',
          ),
        ],
      ),
    );
  }
}

class _EvidenceSection extends StatelessWidget {
  const _EvidenceSection();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _Section(
      tone: _SectionTone.soft,
      eyebrow: '06 · EVIDENZE',
      title: 'Cosa dimostra questo progetto',
      intro:
          'Il repository è privato perché Shavette è un prodotto commerciale. Questa pagina espone però le responsabilità tecniche e le scelte verificabili nel prodotto, senza pubblicare il codice sorgente.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 840;

          final image = ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              color: scheme.surface,
              child: Image.asset(
                'assets/images/shavette/shavette_agenda.jpg',
                fit: BoxFit.cover,
              ),
            ),
          );

          const bullets = _EvidenceBullets();

          if (compact) {
            return Column(
              children: [
                image,
                const SizedBox(height: 28),
                bullets,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 5, child: image),
              const SizedBox(width: 46),
              const Expanded(flex: 5, child: bullets),
            ],
          );
        },
      ),
    );
  }
}

class _EvidenceBullets extends StatelessWidget {
  const _EvidenceBullets();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _EvidenceItem(
          title: 'Flutter oltre la UI',
          body:
              'State management, routing, integrazione servizi nativi e gestione asincrona.',
        ),
        _EvidenceItem(
          title: 'Backend e sicurezza',
          body:
              'Cloud Functions, Firestore, auth, regole di accesso e test server-side.',
        ),
        _EvidenceItem(
          title: 'Integrazione di servizi reali',
          body:
              'FCM, RevenueCat, Google Sign-In, Sign in with Apple e calendari dispositivo.',
        ),
        _EvidenceItem(
          title: 'Ownership del ciclo di vita',
          body:
              'Dalla feature al deploy, passando per bugfix, review degli store e manutenzione.',
        ),
      ],
    );
  }
}

class _FinalCta extends StatelessWidget {
  final VoidCallback onLinkedInTap;
  final VoidCallback onEmailTap;

  const _FinalCta({
    required this.onLinkedInTap,
    required this.onEmailTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _PageWidth(
      padding: const EdgeInsets.symmetric(vertical: 72),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              scheme.primary.withValues(alpha: 0.14),
              scheme.secondary.withValues(alpha: 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: scheme.primary.withValues(alpha: 0.18),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 760;

            final copy = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cerco un team in cui portare questa esperienza su un prodotto più grande.',
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 28,
                    height: 1.2,
                    fontWeight: FontWeight.w850,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Flutter, mobile engineering e prodotti con backend Firebase sono il contesto in cui posso contribuire da subito e continuare a crescere.',
                  style: TextStyle(
                    color: scheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
              ],
            );

            final actions = Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: onLinkedInTap,
                  icon: const Icon(Icons.person_add_alt_1_rounded),
                  label: const Text('Contattami su LinkedIn'),
                ),
                OutlinedButton.icon(
                  onPressed: onEmailTap,
                  icon: const Icon(Icons.mail_outline_rounded),
                  label: const Text('Scrivimi'),
                ),
              ],
            );

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  copy,
                  const SizedBox(height: 26),
                  actions,
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: copy),
                const SizedBox(width: 36),
                actions,
              ],
            );
          },
        ),
      ),
    );
  }
}

enum _SectionTone { plain, soft }

class _Section extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String intro;
  final Widget child;
  final _SectionTone tone;

  const _Section({
    required this.eyebrow,
    required this.title,
    required this.intro,
    required this.child,
    this.tone = _SectionTone.plain,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      color: tone == _SectionTone.soft
          ? scheme.surfaceContainerLowest.withValues(alpha: 0.5)
          : null,
      child: _PageWidth(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eyebrow,
              style: TextStyle(
                color: scheme.primary,
                fontSize: 12,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Text(
                title,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontSize: 36,
                  height: 1.15,
                  letterSpacing: -1,
                  fontWeight: FontWeight.w850,
                ),
              ),
            ),
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 850),
              child: Text(
                intro,
                style: TextStyle(
                  color: scheme.onSurface.withValues(alpha: 0.69),
                  fontSize: 17,
                  height: 1.65,
                ),
              ),
            ),
            const SizedBox(height: 34),
            child,
          ],
        ),
      ),
    );
  }
}

class _PageWidth extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _PageWidth({
    required this.child,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.sizeOf(context).width < 700 ? 20 : 36,
            padding.vertical / 2,
            MediaQuery.sizeOf(context).width < 700 ? 20 : 36,
            padding.vertical / 2,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GridCards extends StatelessWidget {
  final List<Widget> children;

  const _GridCards({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 980
            ? 3
            : constraints.maxWidth >= 620
            ? 2
            : 1;
        final width = (constraints.maxWidth - ((columns - 1) * 16)) / columns;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final child in children)
              SizedBox(
                width: width,
                child: child,
              ),
          ],
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(minHeight: 190),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: scheme.primary),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 18,
              height: 1.2,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            body,
            style: TextStyle(
              color: scheme.onSurface.withValues(alpha: 0.68),
              fontSize: 14.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchitectureNode extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _ArchitectureNode({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.055),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: scheme.primary.withValues(alpha: 0.14),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: scheme.primary, size: 30),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: scheme.onSurface.withValues(alpha: 0.62),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengeList extends StatelessWidget {
  final List<_Challenge> items;

  const _ChallengeList({required this.items});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 650;
                final number = Text(
                  items[i].number,
                  style: TextStyle(
                    color: scheme.primary,
                    fontSize: 14,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900,
                  ),
                );
                final copy = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items[i].title,
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontSize: 21,
                        height: 1.25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      items[i].body,
                      style: TextStyle(
                        color: scheme.onSurface.withValues(alpha: 0.68),
                        fontSize: 15,
                        height: 1.55,
                      ),
                    ),
                  ],
                );

                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      number,
                      const SizedBox(height: 10),
                      copy,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 70, child: number),
                    Expanded(child: copy),
                  ],
                );
              },
            ),
          ),
          if (i != items.length - 1)
            Divider(
              color: scheme.outline.withValues(alpha: 0.12),
              height: 1,
            ),
        ],
      ],
    );
  }
}

class _Challenge {
  final String number;
  final String title;
  final String body;

  const _Challenge({
    required this.number,
    required this.title,
    required this.body,
  });
}

class _EvidenceItem extends StatelessWidget {
  final String title;
  final String body;

  const _EvidenceItem({
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: scheme.primary,
              size: 19,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    color: scheme.onSurface.withValues(alpha: 0.67),
                    fontSize: 14.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  final String text;

  const _HeroBadge(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.14),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.72),
          fontSize: 11,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String text;

  const _TechChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.82),
          fontSize: 12.5,
          fontWeight: FontWeight.w650,
        ),
      ),
    );
  }
}

class _OutlineChip extends StatelessWidget {
  final String text;

  const _OutlineChip(this.text);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.14),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: scheme.onSurface.withValues(alpha: 0.75),
          fontSize: 13,
          fontWeight: FontWeight.w650,
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;

  const _Metric({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.055),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w850,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}
