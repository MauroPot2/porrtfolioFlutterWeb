import 'package:flutter/material.dart';

/// Mantiene le sezioni del portfolio allineate, responsive e limitate
/// a una larghezza massima coerente.
class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double maxWidth;
  final double minHeight;
  final EdgeInsetsGeometry? padding;

  const SectionContainer({
    required this.child,
    this.color,
    this.maxWidth = 1200,
    this.minHeight = 0,
    this.padding,
    super.key,
  })  : assert(maxWidth > 0),
        assert(minHeight >= 0);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 700;

        final resolvedPadding = padding ??
            EdgeInsets.symmetric(
              horizontal: isCompact ? 20 : 48,
              vertical: isCompact ? 56 : 80,
            );

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: minHeight),
          color: color,
          padding: resolvedPadding,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
