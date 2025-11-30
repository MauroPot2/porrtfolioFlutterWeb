import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static final Uri _cvUrl = Uri.parse(
    "https://mauropot2.github.io/porrtfolioFlutterWeb/cv.pdf",
  );

  Future<void> _downloadCV() async {
    if (await canLaunchUrl(_cvUrl)) {
      await launchUrl(
        _cvUrl,
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint("Impossibile aprire il link al CV.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;

          return Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              // FOTO (opzionale)
              Expanded(
                flex: isMobile ? 0 : 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/about_photo.png",
                    width: isMobile ? 250 : 350,
                  ),
                ),
              ),

              SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 40 : 0),

              // TESTO
              Expanded(
                flex: isMobile ? 0 : 6,
                child: Column(
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Chi sono",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      """
Sono Mauro Leonardo Potestio, appassionato di tecnologia, ciclismo e sviluppo software.
Mi piace creare soluzioni digitali che uniscono semplicità, funzionalità e una buona
dose di creatività. Studio e lavoro quotidianamente con Flutter, Python e sviluppo
Full Stack per dar vita a progetti che mi rappresentano.
                      """,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // BUTTON DOWNLOAD CV
                    ElevatedButton.icon(
                      onPressed: _downloadCV,
                      icon: const Icon(Icons.file_download),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Text(
                          "Visualizza il mio CV",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
