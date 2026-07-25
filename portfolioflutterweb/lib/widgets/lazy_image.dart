import 'package:flutter/material.dart';

/// Immagine con placeholder, fade-in e gestione degli errori.
///
/// Può essere usata insieme a un wrapper che rinvia il caricamento
/// finché l'immagine non è vicina al viewport.
class LazyImage extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeInDuration;
  final bool isAsset;

  /// Mantenuto per compatibilità. Flutter applica già la propria cache
  /// agli ImageProvider usati da questo widget.
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

  static Future<void> precacheAsset(
    BuildContext context,
    String imagePath,
  ) async {
    try {
      await precacheImage(AssetImage(imagePath), context);
    } catch (error) {
      debugPrint('Errore nel precaricamento di $imagePath: $error');
    }
  }

  static Future<void> precacheAssets(
    BuildContext context,
    List<String> imagePaths,
  ) async {
    await Future.wait(
      imagePaths.map(
        (path) => precacheAsset(context, path),
      ),
    );
  }

  static Future<void> precacheNetwork(
    BuildContext context,
    String imageUrl,
  ) async {
    try {
      await precacheImage(NetworkImage(imageUrl), context);
    } catch (error) {
      debugPrint('Errore nel precaricamento di $imageUrl: $error');
    }
  }

  int? _cacheDimension(double? value) {
    if (value == null || !value.isFinite || value <= 0) {
      return null;
    }

    return value.round();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final resolvedPlaceholder = placeholder ??
        _ImageSkeleton(
          width: width,
          height: height,
          colorScheme: colorScheme,
          isDark: isDark,
        );

    final resolvedError = errorWidget ??
        _ImageError(
          width: width,
          height: height,
        );

    final image = isAsset
        ? Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: fit,
            gaplessPlayback: true,
            filterQuality: FilterQuality.medium,
            errorBuilder: (context, error, stackTrace) => resolvedError,
            frameBuilder: (
              context,
              child,
              frame,
              wasSynchronouslyLoaded,
            ) {
              if (wasSynchronouslyLoaded) {
                return child;
              }

              return AnimatedSwitcher(
                duration: fadeInDuration,
                child: frame == null
                    ? KeyedSubtree(
                        key: ValueKey('placeholder-$imagePath'),
                        child: resolvedPlaceholder,
                      )
                    : KeyedSubtree(
                        key: ValueKey('image-$imagePath'),
                        child: child,
                      ),
              );
            },
          )
        : Image.network(
            imagePath,
            width: width,
            height: height,
            fit: fit,
            gaplessPlayback: true,
            filterQuality: FilterQuality.medium,
            cacheWidth: _cacheDimension(width),
            cacheHeight: _cacheDimension(height),
            errorBuilder: (context, error, stackTrace) => resolvedError,
            loadingBuilder: (context, child, progress) {
              if (progress == null) {
                return AnimatedOpacity(
                  opacity: 1,
                  duration: fadeInDuration,
                  child: child,
                );
              }

              return resolvedPlaceholder;
            },
          );

    return RepaintBoundary(
      child: SizedBox(
        width: width,
        height: height,
        child: image,
      ),
    );
  }
}

class _ImageError extends StatelessWidget {
  final double? width;
  final double? height;

  const _ImageError({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      color: colorScheme.primary.withValues(alpha: 0.06),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: 42,
            color: colorScheme.onSurface.withValues(alpha: 0.34),
          ),
          const SizedBox(height: 8),
          Text(
            'Immagine non disponibile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface.withValues(alpha: 0.52),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final ColorScheme colorScheme;
  final bool isDark;

  const _ImageSkeleton({
    required this.width,
    required this.height,
    required this.colorScheme,
    required this.isDark,
  });

  @override
  State<_ImageSkeleton> createState() => _ImageSkeletonState();
}

class _ImageSkeletonState extends State<_ImageSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _animation = Tween<double>(
      begin: -1,
      end: 2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final baseAlpha = widget.isDark ? 0.20 : 0.34;
          final highlightAlpha = widget.isDark ? 0.34 : 0.54;

          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.colorScheme.surface.withValues(
                alpha: baseAlpha,
              ),
              gradient: LinearGradient(
                begin: Alignment(_animation.value - 1, 0),
                end: Alignment(_animation.value, 0),
                colors: [
                  widget.colorScheme.surface.withValues(
                    alpha: baseAlpha,
                  ),
                  widget.colorScheme.surface.withValues(
                    alpha: highlightAlpha,
                  ),
                  widget.colorScheme.surface.withValues(
                    alpha: baseAlpha,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
