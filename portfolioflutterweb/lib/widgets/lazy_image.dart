import 'package:flutter/material.dart';

/// Widget per il caricamento lazy delle immagini con placeholder e gestione errori
/// 
/// Per un vero lazy loading basato sul viewport, usa [ViewportAwareImage]
class LazyImage extends StatefulWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeInDuration;
  final bool isAsset;
  
  /// Se true, usa cache per le immagini di rete (default: true)
  final bool useCache;

  const LazyImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.isAsset = true,
    this.useCache = true,
  });

  /// Precarca un'immagine asset per migliorare le performance
  static Future<void> precacheAsset(
    BuildContext context,
    String imagePath,
  ) async {
    try {
      await precacheImage(AssetImage(imagePath), context);
    } catch (e) {
      debugPrint('Errore nel precaricamento di $imagePath: $e');
    }
  }

  /// Precarca una lista di immagini asset
  static Future<void> precacheAssets(
    BuildContext context,
    List<String> imagePaths,
  ) async {
    for (final path in imagePaths) {
      await precacheAsset(context, path);
    }
  }

  /// Precarca un'immagine da network
  static Future<void> precacheNetwork(
    BuildContext context,
    String imageUrl,
  ) async {
    try {
      await precacheImage(NetworkImage(imageUrl), context);
    } catch (e) {
      debugPrint('Errore nel precaricamento di $imageUrl: $e');
    }
  }

  @override
  State<LazyImage> createState() => _LazyImageState();
}

class _LazyImageState extends State<LazyImage> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Placeholder di default (skeleton shimmer)
    final defaultPlaceholder = widget.placeholder ??
        _ImageSkeleton(
          width: widget.width,
          height: widget.height,
          colorScheme: colorScheme,
          isDark: isDark,
        );

    // Widget di errore di default
    final defaultErrorWidget = widget.errorWidget ??
        Container(
          width: widget.width,
          height: widget.height,
          color: colorScheme.surface.withValues(alpha: 0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.broken_image_outlined,
                  size: 48,
                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 8),
                Text(
                  'Immagine non disponibile',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        );

    if (_hasError) {
      return defaultErrorWidget;
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // Placeholder durante il caricamento
        if (_isLoading) defaultPlaceholder,

        // Immagine principale
        widget.isAsset
            ? Image.asset(
                widget.imagePath,
                fit: widget.fit,
                width: widget.width,
                height: widget.height,
                errorBuilder: (context, error, stackTrace) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                        _hasError = true;
                      });
                    }
                  });
                  return defaultErrorWidget;
                },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  // Se l'immagine è già caricata (cache), nascondi il placeholder subito
                  if (wasSynchronouslyLoaded || frame != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() => _isLoading = false);
                      }
                    });
                  }

                  // Se non c'è ancora il frame, mostra il placeholder
                  if (frame == null && !wasSynchronouslyLoaded) {
                    return defaultPlaceholder;
                  }

                  // Anima il fade-in quando l'immagine è pronta
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: widget.fadeInDuration,
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
              )
            : Image.network(
                widget.imagePath,
                fit: widget.fit,
                width: widget.width,
                height: widget.height,
                cacheWidth: widget.width != null ? widget.width!.toInt() : null,
                cacheHeight: widget.height != null ? widget.height!.toInt() : null,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() => _isLoading = false);
                      }
                    });
                    return child;
                  }
                  return defaultPlaceholder;
                },
                errorBuilder: (context, error, stackTrace) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                        _hasError = true;
                      });
                    }
                  });
                  return defaultErrorWidget;
                },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded || frame != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() => _isLoading = false);
                      }
                    });
                  }
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: widget.fadeInDuration,
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
              ),
      ],
    );
  }
}

/// Widget skeleton shimmer per il placeholder
class _ImageSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final ColorScheme colorScheme;
  final bool isDark;

  const _ImageSkeleton({
    this.width,
    this.height,
    required this.colorScheme,
    required this.isDark,
  });

  @override
  State<_ImageSkeleton> createState() => _ImageSkeletonState();
}

class _ImageSkeletonState extends State<_ImageSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.colorScheme.surface.withValues(
              alpha: widget.isDark ? 0.2 : 0.3,
            ),
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: [
                widget.colorScheme.surface.withValues(
                  alpha: widget.isDark ? 0.2 : 0.3,
                ),
                widget.colorScheme.surface.withValues(
                  alpha: widget.isDark ? 0.35 : 0.5,
                ),
                widget.colorScheme.surface.withValues(
                  alpha: widget.isDark ? 0.2 : 0.3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
