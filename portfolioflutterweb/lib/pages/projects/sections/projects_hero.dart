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
            "Una raccolta dei miei progetti più importanti.\n"
            "Flutter · Python · Full Stack · Web.",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
