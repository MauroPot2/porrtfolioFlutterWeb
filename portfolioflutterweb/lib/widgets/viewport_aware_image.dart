import 'package:flutter/material.dart';
import 'lazy_image.dart';

/// Widget che carica l'immagine solo quando entra nel viewport (lazy loading vero)
/// 
/// Questo widget migliora le performance caricando le immagini solo quando
/// sono effettivamente visibili o prossime ad esserlo (configurabile con preloadOffset)
class ViewportAwareImage extends StatefulWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeInDuration;
  final bool isAsset;
  
  /// Offset in pixel prima del viewport per iniziare il caricamento
  /// Es: 200 significa che inizierà a caricare 200px prima che l'immagine entri nel viewport
  final double preloadOffset;

  const ViewportAwareImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.isAsset = true,
    this.preloadOffset = 200.0,
  });

  @override
  State<ViewportAwareImage> createState() => _ViewportAwareImageState();
}

class _ViewportAwareImageState extends State<ViewportAwareImage> {
  final GlobalKey _key = GlobalKey();
  bool _shouldLoad = false;
  ScrollController? _scrollController;
  DateTime? _lastCheck;

  @override
  void initState() {
    super.initState();
    // Controlla immediatamente se l'immagine è già visibile
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
      _setupScrollListener();
    });
  }

  void _setupScrollListener() {
    // Trova lo ScrollController più vicino
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable != null) {
      _scrollController = scrollable.widget.controller;
      _scrollController?.addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (!_shouldLoad && mounted) {
      // Debounce: controlla al massimo ogni 100ms durante lo scroll
      final now = DateTime.now();
      if (_lastCheck == null || 
          now.difference(_lastCheck!).inMilliseconds > 100) {
        _lastCheck = now;
        _checkVisibility();
      }
    }
  }

  void _checkVisibility() {
    if (_shouldLoad || !mounted) return;

    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) {
      // Se il renderBox non è ancora disponibile, riprova dopo un breve delay
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && !_shouldLoad) {
          _checkVisibility();
        }
      });
      return;
    }

    try {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;

      // Controlla se l'immagine è visibile o prossima ad esserlo
      // Considera anche la larghezza per immagini molto larghe
      final isVisible = position.dy < screenHeight + widget.preloadOffset &&
          position.dy + size.height > -widget.preloadOffset &&
          position.dx < screenWidth + widget.preloadOffset &&
          position.dx + size.width > -widget.preloadOffset;

      if (isVisible && !_shouldLoad) {
        setState(() {
          _shouldLoad = true;
        });
        // Rimuovi il listener una volta che abbiamo iniziato a caricare
        _scrollController?.removeListener(_onScroll);
      }
    } catch (e) {
      // Se c'è un errore, carica comunque l'immagine per sicurezza
      // dopo un breve delay per evitare loop infiniti
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && !_shouldLoad) {
          setState(() {
            _shouldLoad = true;
          });
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ricontrolla la visibilità quando cambiano le dipendenze (es. MediaQuery)
    if (!_shouldLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkVisibility();
      });
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _key,
      width: widget.width,
      height: widget.height,
      child: _shouldLoad
          ? LazyImage(
              imagePath: widget.imagePath,
              fit: widget.fit,
              width: widget.width,
              height: widget.height,
              placeholder: widget.placeholder,
              errorWidget: widget.errorWidget,
              fadeInDuration: widget.fadeInDuration,
              isAsset: widget.isAsset,
            )
          : (widget.placeholder ??
              _ImageSkeleton(
                width: widget.width,
                height: widget.height,
                colorScheme: Theme.of(context).colorScheme,
                isDark: Theme.of(context).brightness == Brightness.dark,
              )),
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
