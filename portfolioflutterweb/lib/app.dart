import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/core/theme/app_theme.dart';
import 'package:portfolioflutterweb/router/router.dart';


class PorftfolioApp extends StatelessWidget {
  const PorftfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Mauro Leonardo Potestio - Portfolio",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}