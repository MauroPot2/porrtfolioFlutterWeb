import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/pages/home/sections/contact_section.dart';
import 'package:portfolioflutterweb/pages/home/sections/hero_section.dart';
import 'package:portfolioflutterweb/pages/home/sections/projects_section.dart';
import 'package:portfolioflutterweb/pages/home/sections/service_section.dart';
import 'package:portfolioflutterweb/pages/home/sections/skills_section.dart';
import 'package:portfolioflutterweb/widgets/footer.dart';
import 'package:portfolioflutterweb/widgets/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            HeroSection(),
            SkillsSection(),
            ProjectsSection(),
            ServicesSection(),
            ContactSection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
