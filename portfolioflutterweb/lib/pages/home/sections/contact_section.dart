import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const String _email = 'mauroleonardo.potestio@gmail.com';
  static const String _whatsAppNumber = '393465470904';

  static final Uri _linkedInUri = Uri.parse(
    'https://www.linkedin.com/in/mauroleonardo-potestio',
  );

  Future<void> _openEmail(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: _email,
      queryParameters: const {
        'subject': 'Contatto dal portfolio di Mauro Potestio',
      },
    );

    await _launch(
      context,
      uri,
      errorMessage: 'Non riesco ad aprire il client email.',
    );
  }

  Future<void> _openWhatsApp(BuildContext context) async {
    final uri = Uri.https('wa.me', '/$_whatsAppNumber', const {
      'text': 'Ciao Mauro, ti contatto dopo aver visitato il tuo portfolio.',
    });

    await _launch(context, uri, errorMessage: 'Non riesco ad aprire WhatsApp.');
  }

  Future<void> _openLinkedIn(BuildContext context) async {
    await _launch(
      context,
      _linkedInUri,
      errorMessage: 'Non riesco ad aprire LinkedIn.',
    );
  }

  Future<void> _launch(
    BuildContext context,
    Uri uri, {
    required String errorMessage,
  }) async {
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.platformDefault);

      if (!opened && context.mounted) {
        _showError(context, errorMessage);
      }
    } catch (_) {
      if (context.mounted) {
        _showError(context, errorMessage);
      }
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SectionContainer(
      color: cs.surfaceContainerLow,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 46),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.75)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.11),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Icon(
                Icons.mark_email_read_rounded,
                color: cs.primary,
                size: 31,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Parliamo del prossimo progetto',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.6,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                'Sono disponibile per opportunità come Flutter developer, '
                'collaborazioni e prodotti digitali da costruire o migliorare.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  height: 1.55,
                  color: cs.onSurface.withValues(alpha: 0.72),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SelectableText(
              _email,
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.primary, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _openEmail(context),
                  icon: const Icon(Icons.email_outlined, size: 20),
                  label: const Text('Invia un’email'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 17,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () => _openLinkedIn(context),
                  icon: const Icon(Icons.person_outline_rounded, size: 20),
                  label: const Text('LinkedIn'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: cs.onSurface,
                    side: BorderSide(color: cs.outlineVariant),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 17,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openWhatsApp(context),
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
                  label: const Text('WhatsApp'),
                  style: TextButton.styleFrom(
                    foregroundColor: cs.onSurface,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 17,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
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
        ),
      ),
    );
  }
}
