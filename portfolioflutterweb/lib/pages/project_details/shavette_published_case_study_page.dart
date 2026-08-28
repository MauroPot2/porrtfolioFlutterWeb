import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'shavette_case_study_page.dart';

class ShavettePublishedCaseStudyPage extends StatelessWidget {
  const ShavettePublishedCaseStudyPage({super.key});

  static final Uri _appStoreUri = Uri.parse(
    'https://apps.apple.com/it/app/shavette/id6771834454',
  );
  static final Uri _playStoreUri = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.mauropot.shavette&hl=it',
  );

  Future<void> _open(Uri uri) async {
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _StoreAvailabilityBar(
            onAppStoreTap: () => _open(_appStoreUri),
            onPlayStoreTap: () => _open(_playStoreUri),
          ),
          const Expanded(child: ShavetteCaseStudyPage()),
        ],
      ),
    );
  }
}

class _StoreAvailabilityBar extends StatelessWidget {
  final VoidCallback onAppStoreTap;
  final VoidCallback onPlayStoreTap;

  const _StoreAvailabilityBar({
    required this.onAppStoreTap,
    required this.onPlayStoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0B1020),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 760;

              final status = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF34D399),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'LIVE ON STORES',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.7,
                    ),
                  ),
                ],
              );

              final appStoreButton = OutlinedButton.icon(
                onPressed: onAppStoreTap,
                icon: const Icon(Icons.phone_iphone_rounded, size: 18),
                label: const Text('App Store'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                ),
              );

              final playStoreButton = OutlinedButton.icon(
                onPressed: onPlayStoreTap,
                icon: const Icon(Icons.android_rounded, size: 18),
                label: const Text('Google Play'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                ),
              );

              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    status,
                    const SizedBox(height: 8),
                    Text(
                      'Shavette è già disponibile su App Store e Google Play.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.72),
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [appStoreButton, playStoreButton],
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  status,
                  const SizedBox(width: 18),
                  Expanded(
                    child: Text(
                      'Shavette è già disponibile su App Store e Google Play.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.72),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  appStoreButton,
                  const SizedBox(width: 8),
                  playStoreButton,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
