import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/pages/home/sections/contact_section.dart';
import 'package:portfolioflutterweb/pages/projects/sections/projects_grid.dart';
import 'package:portfolioflutterweb/pages/projects/sections/projects_hero.dart';
import 'package:portfolioflutterweb/widgets/footer.dart';
import 'package:portfolioflutterweb/widgets/navbar.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Navbar(),
              ProjectsHeroSection(),
              ProjectsGridSection(),
              ContactSection(),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
