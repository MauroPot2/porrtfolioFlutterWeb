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
    await launchUrl(uri);
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
              const _ContextSection(),
              const _ResponsibilitiesSection(),
              const _ArchitectureSection(),
              const _ChallengesSection(),
              const _EvidenceSection(),
              _ContactSection(
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
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF111827),
            Color(0xFF151B2E),
            Color(0xFF251A32),
          ],
        ),
      ),
      child: _ContentWidth(
        verticalPadding: 72,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 860;

            final copy = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _DarkBadge('PRODUCT CASE STUDY'),
                    _DarkBadge('REPOSITORY PRIVATE'),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Shavette',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 58,
                    height: 1,
                    letterSpacing: -2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Flutter, Firebase e responsabilità end-to-end su un prodotto reale.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.86),
                    fontSize: 23,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Shavette è il progetto con cui mostro come affronto problemi che vanno oltre la UI: booking, autenticazione, ruoli, backend serverless, notifiche, subscription, flavor e distribuzione mobile.',
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
                    _DarkChip('Flutter'),
                    _DarkChip('Dart'),
                    _DarkChip('Riverpod'),
                    _DarkChip('Firebase Auth'),
                    _DarkChip('Cloud Firestore'),
                    _DarkChip('Cloud Functions'),
                    _DarkChip('FCM'),
                    _DarkChip('RevenueCat'),
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
                        backgroundColor: scheme.primary,
                        foregroundColor: scheme.onPrimary,
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
                          color: Colors.white.withValues(alpha: 0.28),
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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.055),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.11),
                ),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: 1.6,
                      child: Image.asset(
                        'assets/images/shavette/shavette_agenda.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(
                        child: _Metric(
                          value: 'E2E',
                          label: 'ownership',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _Metric(
                          value: 'Cloud',
                          label: 'backend',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        child: _Metric(
                          value: '2',
                          label: 'mobile flavor',
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

            if (isCompact) {
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

class _ContextSection extends StatelessWidget {
  const _ContextSection();

  @override
  Widget build(BuildContext context) {
    return const _Section(
      eyebrow: '01 · CONTESTO',
      title: 'Non una demo: un prodotto con vincoli reali',
      intro:
          'Shavette è una piattaforma di prenotazione per barber shop e saloni. Il progetto mi ha portato a gestire contemporaneamente esperienza utente, dominio booking, sicurezza, backend, monetizzazione e vincoli degli store.',
      child: _ResponsiveGrid(
        children: [
          _InfoCard(
            icon: Icons.groups_2_outlined,
            title: 'Utenti con esigenze diverse',
            body:
                'Cliente, owner e staff condividono lo stesso ecosistema, ma con flussi e permessi differenti.',
          ),
          _InfoCard(
            icon: Icons.event_available_outlined,
            title: 'Booking come dominio centrale',
            body:
                'Disponibilità, servizi, agenda, staff, chiusure e reminder devono rimanere coerenti nello stesso modello dati.',
          ),
          _InfoCard(
            icon: Icons.storefront_outlined,
            title: 'White-label dalla stessa codebase',
            body:
                'Flavor distinti permettono di produrre applicazioni brandizzate mantenendo condivisa la logica principale.',
          ),
        ],
      ),
    );
  }
}

class _ResponsibilitiesSection extends StatelessWidget {
  const _ResponsibilitiesSection();

  @override
  Widget build(BuildContext context) {
    return const _Section(
      softBackground: true,
      eyebrow: '02 · RESPONSABILITÀ',
      title: 'Dal widget al backend, fino alla release',
      intro:
          'Il valore del progetto è nell’ownership del ciclo completo: non una singola schermata, ma l’insieme di componenti necessari per far funzionare un prodotto mobile.',
      child: _ResponsiveGrid(
        children: [
          _InfoCard(
            icon: Icons.phone_iphone_rounded,
            title: 'Applicazione Flutter',
            body:
                'Interfaccia, navigazione con GoRouter, state management con Riverpod e organizzazione feature-first.',
          ),
          _InfoCard(
            icon: Icons.lock_outline_rounded,
            title: 'Auth, ruoli e permessi',
            body:
                'Firebase Authentication e logiche di accesso dedicate a owner, staff e utenti finali.',
          ),
          _InfoCard(
            icon: Icons.cloud_queue_rounded,
            title: 'Backend serverless',
            body:
                'Cloud Functions e Firestore per disponibilità, prenotazioni, staff e operazioni sensibili.',
          ),
          _InfoCard(
            icon: Icons.notifications_active_outlined,
            title: 'Push e reminder',
            body:
                'Firebase Cloud Messaging e notifiche locali per eventi applicativi e promemoria appuntamento.',
          ),
          _InfoCard(
            icon: Icons.workspace_premium_outlined,
            title: 'Subscription',
            body:
                'RevenueCat per entitlement e flussi di abbonamento coerenti tra Android e iOS.',
          ),
          _InfoCard(
            icon: Icons.rocket_launch_outlined,
            title: 'Build & release',
            body:
                'Flavor, versioning, configurazioni piattaforma e gestione dei requisiti di review degli store.',
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
      title: 'Responsabilità separate, flusso leggibile',
      intro:
          'L’architettura mantiene distinti presentazione, stato, accesso ai dati e logica server, così da evitare di concentrare il comportamento applicativo nei widget.',
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 760;
              const nodes = [
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
                    for (var i = 0; i < nodes.length; i++) ...[
                      nodes[i],
                      if (i < nodes.length - 1)
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
                children: [
                  for (var i = 0; i < nodes.length; i++) ...[
                    Expanded(child: nodes[i]),
                    if (i < nodes.length - 1)
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
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: const Wrap(
              spacing: 9,
              runSpacing: 9,
              children: [
                _LightChip('Firebase Authentication'),
                _LightChip('Cloud Firestore'),
                _LightChip('Cloud Functions'),
                _LightChip('Firebase Messaging'),
                _LightChip('Google Sign-In'),
                _LightChip('Sign in with Apple'),
                _LightChip('RevenueCat'),
                _LightChip('Flutter flavors'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengesSection extends StatelessWidget {
  const _ChallengesSection();

  @override
  Widget build(BuildContext context) {
    return const _Section(
      softBackground: true,
      eyebrow: '04 · ENGINEERING CHALLENGES',
      title: 'Problemi che non si risolvono con un tutorial',
      intro:
          'Le parti più formative sono state quelle in cui sicurezza, asincronia, business logic e servizi esterni dovevano convivere senza rendere fragile il prodotto.',
      child: _ChallengeList(
        items: [
          _Challenge(
            number: '01',
            title: 'Accesso multi-ruolo',
            body:
                'Separazione tra owner e staff, controlli lato backend e test dedicati per evitare permessi eccessivi.',
          ),
          _Challenge(
            number: '02',
            title: 'Reminder legati agli appuntamenti',
            body:
                'Sincronizzazione tra dati Firestore, scheduling server-side, token FCM e comportamento locale del dispositivo.',
          ),
          _Challenge(
            number: '03',
            title: 'Subscription e stato applicativo',
            body:
                'Gli entitlement RevenueCat non vengono trattati come semplice stato UI, ma come parte del modello di accesso al prodotto.',
          ),
          _Challenge(
            number: '04',
            title: 'Una codebase, più brand',
            body:
                'Flavor e configurazioni separate gestiscono bundle, icone e identità mantenendo condiviso il core applicativo.',
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
    return _Section(
      eyebrow: '05 · COSA DIMOSTRA',
      title: 'Competenze applicate, non soltanto dichiarate',
      intro:
          'Il repository è privato perché Shavette è un prodotto commerciale. Il case study rende però visibili le responsabilità tecniche e il tipo di problemi affrontati senza pubblicare il sorgente.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 820;

          final screenshot = ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/shavette/shavette_agenda.jpg',
              fit: BoxFit.cover,
            ),
          );

          const evidence = Column(
            children: [
              _EvidenceItem(
                title: 'Flutter oltre la UI',
                body:
                    'State management, routing, integrazione di servizi nativi e gestione asincrona.',
              ),
              _EvidenceItem(
                title: 'Backend e sicurezza',
                body:
                    'Cloud Functions, Firestore, autenticazione, ruoli e test lato server.',
              ),
              _EvidenceItem(
                title: 'Servizi reali',
                body:
                    'FCM, RevenueCat, Google Sign-In, Sign in with Apple e integrazione calendario.',
              ),
              _EvidenceItem(
                title: 'Ownership del ciclo di vita',
                body:
                    'Feature, bugfix, test, deploy, flavor e requisiti legati agli store.',
              ),
            ],
          );

          if (compact) {
            return Column(
              children: [
                screenshot,
                const SizedBox(height: 28),
                evidence,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 5, child: screenshot),
              const SizedBox(width: 44),
              const Expanded(flex: 5, child: evidence),
            ],
          );
        },
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  final VoidCallback onLinkedInTap;
  final VoidCallback onEmailTap;

  const _ContactSection({
    required this.onLinkedInTap,
    required this.onEmailTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _ContentWidth(
      verticalPadding: 72,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(34),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              scheme.primary.withValues(alpha: 0.13),
              scheme.secondary.withValues(alpha: 0.07),
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
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w800,
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
                  label: const Text('LinkedIn'),
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
                  const SizedBox(height: 24),
                  actions,
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: copy),
                const SizedBox(width: 32),
                actions,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String intro;
  final Widget child;
  final bool softBackground;

  const _Section({
    required this.eyebrow,
    required this.title,
    required this.intro,
    required this.child,
    this.softBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      color: softBackground
          ? scheme.surfaceContainerLowest.withValues(alpha: 0.5)
          : null,
      child: _ContentWidth(
        verticalPadding: 64,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eyebrow,
              style: TextStyle(
                color: scheme.primary,
                fontSize: 12,
                letterSpacing: 1.4,
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
                  fontWeight: FontWeight.w800,
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

class _ContentWidth extends StatelessWidget {
  final Widget child;
  final double verticalPadding;

  const _ContentWidth({
    required this.child,
    required this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final horizontal = MediaQuery.sizeOf(context).width < 700 ? 20.0 : 36.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontal,
            vertical: verticalPadding,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;

  const _ResponsiveGrid({required this.children});

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
      constraints: const BoxConstraints(minHeight: 188),
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
          if (i < items.length - 1)
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

class _DarkBadge extends StatelessWidget {
  final String text;

  const _DarkBadge(this.text);

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
          letterSpacing: 1.1,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _DarkChip extends StatelessWidget {
  final String text;

  const _DarkChip(this.text);

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
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _LightChip extends StatelessWidget {
  final String text;

  const _LightChip(this.text);

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
          fontWeight: FontWeight.w600,
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
              fontWeight: FontWeight.w800,
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
