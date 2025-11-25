import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/projects.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool menuOpen = false;
  bool showProjectsSubmenu = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 750;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      color: cs.surface.withValues(alpha: 0.95),
      child: Column(
        children: [
          Row(
            children: [
              // LOGO / TITOLO
              InkWell(
                onTap: () => context.go("/"),
                child: Text(
                  "mauropot.com",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
              ),

              const Spacer(),

              // -------------------------
              // DESKTOP MENU
              // -------------------------
              if (!isMobile) ...[
                _navItem(context, "Home", "/"),
                _navItem(context, "Chi Sono", "/about"),
                _navItem(context, "Contatti", "/contact"),

                // MENU PROGETTI A TENDINA
                MouseRegion(
                  onEnter: (_) => setState(() => showProjectsSubmenu = true),
                  onExit: (_) => setState(() => showProjectsSubmenu = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Progetti",
                              style: TextStyle(
                                fontSize: 16,
                                color: cs.onSurface,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(Icons.keyboard_arrow_down,
                                size: 20, color: cs.onSurface),
                          ],
                        ),

                        // Submenu
                        if (showProjectsSubmenu)
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: cs.surface.withValues(alpha: 0.95),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: cs.onSurface.withValues(alpha: 0.15),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: myProjects.map((p) {
                                return InkWell(
                                  onTap: () => context.go("/projects/${p.id}"),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 4),
                                    child: Text(
                                      p.title,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: cs.onSurface,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],

              // -------------------------
              // MOBILE HAMBURGER
              // -------------------------
              if (isMobile)
                IconButton(
                  icon: Icon(
                    menuOpen ? Icons.close : Icons.menu,
                    size: 28,
                    color: cs.onSurface,
                  ),
                  onPressed: () {
                    setState(() => menuOpen = !menuOpen);
                  },
                ),
            ],
          ),

          // -------------------------
          // MOBILE MENU
          // -------------------------
          if (isMobile && menuOpen)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _mobileNavItem(context, "Home", "/"),
                _mobileNavItem(context, "Chi Sono", "/about"),
                _mobileNavItem(context, "Contatti", "/contact"),

                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: EdgeInsets.zero,
                  initiallyExpanded: false,
                  title: Text(
                    "Progetti",
                    style: TextStyle(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  children: myProjects.map((p) {
                    return _mobileNavItem(context, p.title, "/projects/${p.id}");
                  }).toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // -------------------------
  // DESKTOP NAV ITEM
  // -------------------------
  Widget _navItem(BuildContext context, String text, String route) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: () => context.go(route),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: cs.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // -------------------------
  // MOBILE NAV ITEM
  // -------------------------
  Widget _mobileNavItem(BuildContext context, String text, String route) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          setState(() => menuOpen = false);
          context.go(route);
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: cs.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
