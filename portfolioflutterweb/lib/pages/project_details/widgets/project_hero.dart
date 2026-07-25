import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolioflutterweb/models/project.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectHero extends StatelessWidget {
  final Project project;

  const ProjectHero({super.key, required this.project});

  Future<void> _openProjectLink(BuildContext context) async {
    final rawLink = project.link.trim();
    final uri = Uri.tryParse(rawLink);

    if (rawLink.isEmpty || uri == null) {
      _showLaunchError(context);
      return;
    }

    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!opened && context.mounted) {
        _showLaunchError(context);
      }
    } catch (_) {
      if (context.mounted) {
        _showLaunchError(context);
      }
    }
  }

  void _showLaunchError(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Impossibile aprire il collegamento del progetto.'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SectionContainer(
      minHeight: 380,
      color: colorScheme.primary.withValues(alpha: isDark ? 0.08 : 0.05),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 700;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () => context.go('/projects'),
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.onSurface,
                  padding: EdgeInsets.zero,
                ),
                icon: const Icon(Icons.arrow_back_rounded, size: 20),
                label: const Text('Tutti i progetti'),
              ),
              const SizedBox(height: 36),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'CASO STUDIO',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                project.title,
                style: TextStyle(
                  fontSize: isCompact ? 38 : 56,
                  height: 1.05,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.2,
                  color: colorScheme.onSurface,
                ),
              ),
              if (project.subtitle?.trim().isNotEmpty ?? false) ...[
                const SizedBox(height: 18),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Text(
                    project.subtitle!.trim(),
                    style: TextStyle(
                      fontSize: isCompact ? 18 : 21,
                      height: 1.5,
                      color: colorScheme.onSurface.withValues(alpha: 0.72),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              OutlinedButton.icon(
                onPressed: () => _openProjectLink(context),
                icon: const Icon(Icons.open_in_new_rounded, size: 19),
                label: const Text('Apri il progetto'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.onSurface,
                  side: BorderSide(
                    color: colorScheme.primary.withValues(alpha: 0.45),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 17,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
