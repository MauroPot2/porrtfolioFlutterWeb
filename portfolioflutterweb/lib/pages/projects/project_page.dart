import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/pages/home/sections/contact_section.dart';
import 'package:portfolioflutterweb/widgets/navbar.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Navbar(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}
