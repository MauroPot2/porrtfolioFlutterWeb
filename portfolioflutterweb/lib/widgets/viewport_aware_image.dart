import 'package:flutter/material.dart';

import 'lazy_image.dart';

/// Carica l'immagine quando entra nel viewport o si avvicina a esso.
///
/// Ascolta direttamente la [ScrollPosition] più vicina, quindi funziona anche
/// quando il relativo [SingleChildScrollView] non riceve un controller esplicito.
class ViewportAwareImage extends StatefulWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeInDuration;
  final bool isAsset;
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
    this.preloadOffset = 200,
  }) : assert(preloadOffset >= 0);

  @override
  State<ViewportAwareImage> createState() => _ViewportAwareImageState();
}

class _ViewportAwareImageState extends State<ViewportAwareImage> {
  final GlobalKey _renderKey = GlobalKey();

  final Set<ScrollPosition> _scrollPositions = <ScrollPosition>{};
  bool _shouldLoad = false;
  bool _checkScheduled = false;
  DateTime? _lastCheck;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scheduleAttachAndCheck();
  }

  @override
  void didUpdateWidget(covariant ViewportAwareImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.imagePath != widget.imagePath ||
        oldWidget.isAsset != widget.isAsset) {
      _shouldLoad = false;
      _scheduleAttachAndCheck();
    }
  }

  void _scheduleAttachAndCheck() {
    if (_checkScheduled) {
      return;
    }

    _checkScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;

      if (!mounted || _shouldLoad) {
        return;
      }

      _attachToAncestorScrollPositions();
      _checkVisibility();
    });
  }

  void _attachToAncestorScrollPositions() {
    final positions = <ScrollPosition>{};

    context.visitAncestorElements((element) {
      if (element is StatefulElement && element.state is ScrollableState) {
        positions.add((element.state as ScrollableState).position);
      }

      return true;
    });

    for (final position in _scrollPositions.difference(positions)) {
      position.removeListener(_onScroll);
    }

    for (final position in positions.difference(_scrollPositions)) {
      position.addListener(_onScroll);
    }

    _scrollPositions
      ..clear()
      ..addAll(positions);
  }

  void _detachScrollListeners() {
    for (final position in _scrollPositions) {
      position.removeListener(_onScroll);
    }

    _scrollPositions.clear();
  }

  void _onScroll() {
    if (_shouldLoad || !mounted) {
      return;
    }

    final now = DateTime.now();

    if (_lastCheck != null &&
        now.difference(_lastCheck!).inMilliseconds < 80) {
      return;
    }

    _lastCheck = now;
    _checkVisibility();
  }

  void _checkVisibility() {
    if (_shouldLoad || !mounted) {
      return;
    }

    final renderObject = _renderKey.currentContext?.findRenderObject();

    if (renderObject is! RenderBox || !renderObject.attached) {
      _scheduleAttachAndCheck();
      return;
    }

    try {
      final topLeft = renderObject.localToGlobal(Offset.zero);
      final size = renderObject.size;
      final viewportSize = MediaQuery.sizeOf(context);
      final offset = widget.preloadOffset;

      final intersectsViewport =
          topLeft.dy < viewportSize.height + offset &&
          topLeft.dy + size.height > -offset &&
          topLeft.dx < viewportSize.width + offset &&
          topLeft.dx + size.width > -offset;

      if (intersectsViewport) {
        _startLoading();
      }
    } catch (_) {
      // In caso di trasformazioni o render tree non standard, è preferibile
      // caricare l'immagine piuttosto che lasciare un placeholder permanente.
      _startLoading();
    }
  }

  void _startLoading() {
    if (_shouldLoad || !mounted) {
      return;
    }

    setState(() => _shouldLoad = true);
    _detachScrollListeners();
  }

  @override
  void dispose() {
    _detachScrollListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _renderKey,
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
          : widget.placeholder ?? const _ViewportPlaceholder(),
    );
  }
}

class _ViewportPlaceholder extends StatelessWidget {
  const _ViewportPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(
          alpha: isDark ? 0.24 : 0.42,
        ),
      ),
    );
  }
}
