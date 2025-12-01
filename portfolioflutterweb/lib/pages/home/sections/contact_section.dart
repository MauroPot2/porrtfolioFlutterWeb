import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const String _email = 'mauroleonardo.potestio@gmail.com';
  static const String _whatsAppNumber = '+393465470904'; // 👈 METTI IL TUO

  Future<void> _openEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: _email,
      queryParameters: {
        'subject': 'Richiesta di contatto dal portfolio',
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Impossibile aprire il client email');
    }
  }

  Future<void> _openWhatsApp() async {
    final text = Uri.encodeComponent('Ciao Mauro, ti ho trovato dal tuo portfolio!');
    final uri = Uri.parse('https://wa.me/${_whatsAppNumber.replaceAll('+', '')}?text=$text');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Impossibile aprire WhatsApp');
    }
  }

  void _showContactDialog(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Scegli come contattarmi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.email_outlined, color: cs.primary),
                title: const Text('Email'),
                subtitle: Text(_email),
                onTap: () {
                  Navigator.of(context).pop();
                  _openEmail();
                },
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.chat_bubble_outline, color: cs.primary),
                title: const Text('WhatsApp'),
                subtitle: Text(_whatsAppNumber),
                onTap: () {
                  Navigator.of(context).pop();
                  _openWhatsApp();
                },
              ),
               const SizedBox(height: 8),
               ListTile(
                 leading: Icon(Icons.person_outline, color: cs.primary),
                 title: const Text('LinkedIn'),
                 subtitle: const Text('linkedin.com/in/mauropot'),
                 onTap: () {
                   Navigator.of(context).pop();
                   launchUrl(Uri.parse('https://www.linkedin.com/in/mauroleonardo-potestio'));
                 },
               ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = cs.brightness == Brightness.dark;

    final bgColor = cs.surface.withValues(
      alpha: isDark ? 0.20 : 0.95,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: bgColor,
      child: Column(
        children: [
          Text(
            "Contattami",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Per collaborazioni, progetti o semplici curiosità.",
            style: TextStyle(
              color: cs.onSurface.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: cs.primary.withValues(alpha: 0.90),
              foregroundColor: cs.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            onPressed: () => _showContactDialog(context),
            icon: const Icon(Icons.send_rounded, size: 20),
            label: const Text(
              "Scrivimi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
