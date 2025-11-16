import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.black87,
      child: const Center(
        child: Text(
          "© 2025 Mauro Leonardo Potestio — Tutti i diritti riservati",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
