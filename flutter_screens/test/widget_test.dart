import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screens/screen/main.dart';

void main() {
  testWidgets('Verificar primera pantalla', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Primera pantalla'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Santiago');

    expect(find.text('Santiago'), findsOneWidget);
  });
}
