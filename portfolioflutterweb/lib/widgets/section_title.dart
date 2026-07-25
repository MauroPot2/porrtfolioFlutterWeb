import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;

  const SectionTitle(
    this.text, {
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 34,
        height: 1.12,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: colorScheme.onSurface,
      ),
    );
  }
}
