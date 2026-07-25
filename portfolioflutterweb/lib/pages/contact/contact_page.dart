import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/pages/home/sections/contact_section.dart';
import 'package:portfolioflutterweb/widgets/footer.dart';
import 'package:portfolioflutterweb/widgets/navbar.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(children: [Navbar(), ContactSection(), Footer()]),
        ),
      ),
    );
  }
}
