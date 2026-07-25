import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/projects.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _menuOpen = false;

  void _navigate(BuildContext context, String route) {
    if (_menuOpen) {
      setState(() => _menuOpen = false);
    }

    context.go(route);
  }

  bool _isActive(String currentPath, String route) {
    if (route == '/') {
      return currentPath == '/';
    }

    return currentPath == route || currentPath.startsWith('$route/');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentPath = GoRouterState.of(context).uri.path;

    return Material(
      color: colorScheme.surface.withValues(
        alpha: isDark ? 0.96 : 0.94,
      ),
      elevation: 0,
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 780;

            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.12),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Semantics(
                        button: true,
                        label: 'Vai alla pagina iniziale',
                        child: InkWell(
                          onTap: () => _navigate(context, '/'),
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 8,
                            ),
                            child: Text(
                              'mauropot.com',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.7,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (!isMobile) ...[
                        _DesktopNavItem(
                          label: 'Home',
                          active: _isActive(currentPath, '/'),
                          onTap: () => _navigate(context, '/'),
                        ),
                        _DesktopNavItem(
                          label: 'Chi sono',
                          active: _isActive(currentPath, '/about'),
                          onTap: () => _navigate(context, '/about'),
                        ),
                        _buildProjectsMenu(
                          context,
                          currentPath: currentPath,
                        ),
                        _DesktopNavItem(
                          label: 'Contatti',
                          active: _isActive(currentPath, '/contact'),
                          onTap: () => _navigate(context, '/contact'),
                        ),
                      ] else
                        IconButton(
                          onPressed: () {
                            setState(() => _menuOpen = !_menuOpen);
                          },
                          tooltip: _menuOpen ? 'Chiudi menu' : 'Apri menu',
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 160),
                            child: Icon(
                              _menuOpen
                                  ? Icons.close_rounded
                                  : Icons.menu_rounded,
                              key: ValueKey(_menuOpen),
                              size: 28,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                    ],
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    child: isMobile && _menuOpen
                        ? _buildMobileMenu(
                            context,
                            currentPath: currentPath,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProjectsMenu(
    BuildContext context, {
    required String currentPath,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final active = _isActive(currentPath, '/projects');

    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          onPressed: () => _navigate(context, '/projects'),
          leadingIcon: const Icon(Icons.grid_view_rounded),
          child: const Text('Tutti i progetti'),
        ),
        const Divider(),
        ...myProjects.map(
          (project) => MenuItemButton(
            onPressed: () => _navigate(
              context,
              '/projects/${project.id}',
            ),
            child: Text(project.title),
          ),
        ),
      ],
      builder: (context, controller, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: InkWell(
            onTap: () {
              controller.isOpen ? controller.close() : controller.open();
            },
            borderRadius: BorderRadius.circular(10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: active
                    ? colorScheme.primary.withValues(alpha: 0.11)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    'Progetti',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: active
                          ? FontWeight.w700
                          : FontWeight.w600,
                      color: active
                          ? colorScheme.primary
                          : colorScheme.onSurface.withValues(alpha: 0.82),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 19,
                    color: active
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.72),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileMenu(
    BuildContext context, {
    required String currentPath,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: Column(
        children: [
          Divider(
            color: colorScheme.outline.withValues(alpha: 0.12),
          ),
          _MobileNavItem(
            label: 'Home',
            active: _isActive(currentPath, '/'),
            onTap: () => _navigate(context, '/'),
          ),
          _MobileNavItem(
            label: 'Chi sono',
            active: _isActive(currentPath, '/about'),
            onTap: () => _navigate(context, '/about'),
          ),
          _MobileNavItem(
            label: 'Progetti',
            active: currentPath == '/projects',
            onTap: () => _navigate(context, '/projects'),
          ),
          ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 12),
            childrenPadding: const EdgeInsets.only(
              left: 18,
              right: 8,
              bottom: 8,
            ),
            shape: const Border(),
            collapsedShape: const Border(),
            iconColor: colorScheme.primary,
            collapsedIconColor:
                colorScheme.onSurface.withValues(alpha: 0.70),
            title: Text(
              'Casi studio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: currentPath.startsWith('/projects/')
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.82),
              ),
            ),
            children: myProjects.map((project) {
              final route = '/projects/${project.id}';

              return _MobileNavItem(
                label: project.title,
                active: currentPath == route,
                subItem: true,
                onTap: () => _navigate(context, route),
              );
            }).toList(),
          ),
          _MobileNavItem(
            label: 'Contatti',
            active: _isActive(currentPath, '/contact'),
            onTap: () => _navigate(context, '/contact'),
          ),
        ],
      ),
    );
  }
}

class _DesktopNavItem extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _DesktopNavItem({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: active
                ? colorScheme.primary.withValues(alpha: 0.11)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: active ? FontWeight.w700 : FontWeight.w600,
              color: active
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.82),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String label;
  final bool active;
  final bool subItem;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.label,
    required this.active,
    required this.onTap,
    this.subItem = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: subItem ? 12 : 0,
        bottom: 3,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: subItem ? 9 : 11,
          ),
          decoration: BoxDecoration(
            color: active
                ? colorScheme.primary.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: subItem ? 15 : 16,
              fontWeight: active ? FontWeight.w700 : FontWeight.w600,
              color: active
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(
                      alpha: subItem ? 0.72 : 0.84,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
