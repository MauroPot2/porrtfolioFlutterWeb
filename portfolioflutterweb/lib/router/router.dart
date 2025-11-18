import 'package:go_router/go_router.dart';
import 'package:portfolioflutterweb/pages/about/about_page.dart';
import 'package:portfolioflutterweb/pages/contact/contact_page.dart';
import 'package:portfolioflutterweb/pages/home/home_page.dart';
import 'package:portfolioflutterweb/pages/projects/projects_page.dart';


class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: ( context, _ ) => const HomePage(), 
        ),
      GoRoute(
        path: '/projects',
        builder: (context, _) => const ProjectsPage() , 
      ),
      GoRoute(
        path: '/about',
        builder: (context, _) => const AboutPage() , 
      ),
      GoRoute(
        path: '/contact',
        builder: (context, _) => const ContactPage() , 
      ),
    ],
  );
}