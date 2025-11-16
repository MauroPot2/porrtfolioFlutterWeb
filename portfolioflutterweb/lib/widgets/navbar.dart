import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        children: [
          const Text(
            "mauropot.com",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),    
          ),
          const Spacer(),
          _navItem(context, "Home", "/"),
          _navItem(context, "Progetti", "/projects"),
          _navItem(context, "Chi Sono", "/about"),
          _navItem(context, "Contatti", "/contact"),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, String text, String route){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () => context.go(route),
        child: Text(text, style: const TextStyle(fontSize: 16),),
      ), 
      );
  }

}