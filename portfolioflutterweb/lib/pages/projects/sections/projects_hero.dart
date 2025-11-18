import 'package:flutter/material.dart';

class ProjectsHeroSection extends StatelessWidget {
  const ProjectsHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Progetti",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            "I miei progetti raccontano il mio percorso: studio, pratica e passione per il digitale.\n"
            "Lavoro soprattutto con Flutter, Python e tecnologie Full Stack.\n"
            "Attualmente sto seguendo un corso in Project Management con Google\n"
            "che mi permette di capire in che modo gestire tempi e ritmi del mio lavoro!", 
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
