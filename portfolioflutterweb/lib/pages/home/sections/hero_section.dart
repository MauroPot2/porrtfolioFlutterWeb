import 'package:flutter/material.dart';

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
        children: const [
          Text(
            "Ciao, sono Mauro 👋",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
