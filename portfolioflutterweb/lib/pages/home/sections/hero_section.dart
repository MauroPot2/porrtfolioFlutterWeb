import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      padding: const EdgeInsets.all(40),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                "Ciao, sono Mauro 👋",
                textStyle: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
                speed: Duration(milliseconds: 70), // velocità del typing
              ),
            ],
            totalRepeatCount: 5, // non ripete all’infinito
            pause: Duration(milliseconds: 800),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
          SizedBox(height: 16),
          Text(
            "Sport leader, ciclista, appassionato di tecnologia.\n"
            "Full Stack Developer — Python & Flutter.",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
