import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payment_flow/main.dart';
import 'package:payment_flow/ui/components/payment_type.dart';
import 'package:payment_flow/ui/screens/payment_details_screen.dart';
import 'package:payment_flow/ui/screens/successful_screen.dart';

Future<void> prepare(
  WidgetTester tester, {
  Size size = const Size(375, 812),
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final manifest = jsonDecode(
      await rootBundle.loadString('FontManifest.json'),
    ) as List<dynamic>;
    for (final entry in manifest) {
      final loader = FontLoader(entry['family'] as String);
      for (final font in entry['fonts'] as List<dynamic>) {
        loader.addFont(rootBundle.load(font['asset'] as String));
      }
      await loader.load();
    }
  });
  testWidgets(
    'Selecciona los cuatro métodos y conserva selección al regresar',
    (tester) async {
      await prepare(tester);
      for (final method in PaymentMethod.values) {
        final option = find.byWidgetPredicate(
          (w) => w is PaymentMethodWidget && w.value == method,
        );
        await tester.tap(option);
        await tester.pumpAndSettle();
        final options = tester.widgetList<PaymentMethodWidget>(
          find.byType(PaymentMethodWidget),
        );
        expect(options.where((w) => w.value == w.selectedValue).length, 1);
        expect(
          tester.widget<PaymentMethodWidget>(option).selectedValue,
          method,
        );
      }
      await tester.tap(find.text('SIGUIENTE'));
      await tester.pumpAndSettle();
      expect(find.byType(PaymentDetailsScreen), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<PaymentMethodWidget>(find.byType(PaymentMethodWidget).last)
            .selectedValue,
        PaymentMethod.bitcoin,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Valida campos, aplica máscaras y entrega argumentos sin historial',
    (tester) async {
      await prepare(tester);
      await tester.tap(find.text('SIGUIENTE'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('CONFIRMAR PAGO'));
      await tester.tap(find.text('CONFIRMAR PAGO'));
      await tester.pumpAndSettle();
      expect(find.text('Ingrese el nombre'), findsOneWidget);
      expect(find.text('Ingrese el número de tarjeta'), findsOneWidget);
      expect(find.text('Ingrese la fecha de expiración'), findsOneWidget);
      expect(find.text('Ingrese el código cvv'), findsOneWidget);
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Santiago Prueba');
      await tester.enterText(fields.at(1), '4111111111111111');
      await tester.enterText(fields.at(2), '1228');
      await tester.enterText(fields.at(3), '12345');
      final edits = tester
          .widgetList<EditableText>(find.byType(EditableText))
          .toList();
      expect(edits[1].controller.text, '4111-1111-1111-1111');
      expect(edits[2].controller.text, '12/28');
      expect(edits[3].controller.text, '123');
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byType(Checkbox));
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
      await tester.ensureVisible(find.text('CONFIRMAR PAGO'));
      await tester.tap(find.text('CONFIRMAR PAGO'));
      await tester.pumpAndSettle();
      expect(find.byType(SuccessfulScreen), findsOneWidget);
      final context = tester.element(find.byType(SuccessfulScreen));
      final args = ModalRoute.of(context)!.settings.arguments! as MyArguments;
      expect(args.name, 'Santiago Prueba');
      expect(args.cardNumber, '4111-1111-1111-1111');
      expect(args.expiryDate, '12/28');
      expect(args.cvvCode, '123');
      expect(args.savedCard, isTrue);
      expect(Navigator.of(context).canPop(), isFalse);
      await tester.tap(find.text('CONTINUAR COMPRANDO'));
      await tester.pumpAndSettle();
      expect(find.text('Método de pago'), findsOneWidget);
      expect(find.byType(SuccessfulScreen), findsNothing);
      expect(
        tester
            .widget<PaymentMethodWidget>(find.byType(PaymentMethodWidget).first)
            .selectedValue,
        PaymentMethod.creditCard,
      );
      await tester.tap(find.text('SIGUIENTE'));
      await tester.pumpAndSettle();
      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);
      for (final edit in tester.widgetList<EditableText>(
        find.byType(EditableText),
      )) {
        expect(edit.controller.text, isEmpty);
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Capturas de las tres pantallas para comparación visual con los PDF',
    (tester) async {
      await prepare(tester);
      await expectLater(
        find.byType(MyApp),
        matchesGoldenFile('screenshots/01_metodos.png'),
      );
      await tester.tap(find.text('SIGUIENTE'));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MyApp),
        matchesGoldenFile('screenshots/02_detalles.png'),
      );
      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.pushNamedAndRemoveUntil(
        '/payment_successful',
        (_) => false,
        arguments: const MyArguments(
          name: 'Prueba',
          cardNumber: '',
          expiryDate: '',
          cvvCode: '',
          savedCard: false,
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MyApp),
        matchesGoldenFile('screenshots/03_finalizar.png'),
      );
      expect(tester.takeException(), isNull);
    },
  );
}
