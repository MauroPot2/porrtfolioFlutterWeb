import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: Colors.black.withOpacity(0.03),
      child: Column(
        children: [
          const Text(
            "Contattami",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text("Per collaborazioni, progetti o semplici curiosità."),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              child: Text("Scrivimi"),
            ),
          )
        ],
      ),
    );
  }
}
