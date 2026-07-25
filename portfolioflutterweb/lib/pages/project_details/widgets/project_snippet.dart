import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolioflutterweb/models/project.dart';
import 'package:portfolioflutterweb/widgets/section_container.dart';

class ProjectSnippet extends StatelessWidget {
  final Project project;

  const ProjectSnippet({super.key, required this.project});

  Future<void> _copySnippet(BuildContext context, String snippet) async {
    await Clipboard.setData(ClipboardData(text: snippet));

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Snippet copiato negli appunti.')),
      );
  }

  @override
  Widget build(BuildContext context) {
    final snippet = project.snippet?.trim() ?? '';

    if (snippet.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SectionContainer(
      maxWidth: 1100,
      color: colorScheme.surface.withValues(alpha: isDark ? 0.20 : 0.65),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dal codice',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0B1220) : const Color(0xFF111827),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.18),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 8,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.code_rounded,
                        size: 19,
                        color: Color(0xFFD1D5DB),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Esempio',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFD1D5DB),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _copySnippet(context, snippet),
                        tooltip: 'Copia il codice',
                        icon: const Icon(
                          Icons.copy_rounded,
                          size: 19,
                          color: Color(0xFFD1D5DB),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color(0xFF374151)),
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(22),
                    child: Text(
                      snippet,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        height: 1.65,
                        color: Color(0xFFF9FAFB),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
