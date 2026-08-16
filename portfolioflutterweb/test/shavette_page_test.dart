import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolioflutterweb/pages/shavette/shavette_page.dart';

void main() {
  testWidgets('shows the Founding Salons offer and its primary CTA', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: ShavettePage()));
    await tester.pump();

    expect(find.text('Cerchiamo i primi 20 saloni.'), findsOneWidget);
    expect(
      find.text('Shavette Pro completo gratis fino al 31 dicembre 2026.'),
      findsOneWidget,
    );
    expect(find.text('CANDIDA IL TUO SALONE'), findsOneWidget);
    expect(find.byType(Image), findsAtLeastNWidgets(2));
  });

  testWidgets('keeps the application form usable on a mobile viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: ShavettePage()));
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text('Raccontaci chi sei'),
      720,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();

    expect(find.text('Nome del salone *'), findsOneWidget);
    expect(find.text('Città *'), findsOneWidget);
    expect(find.text('CANDIDA IL MIO SALONE'), findsOneWidget);
  });
}
