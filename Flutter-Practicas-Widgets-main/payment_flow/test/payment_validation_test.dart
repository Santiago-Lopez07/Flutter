import 'package:flutter_test/flutter_test.dart';
import 'package:payment_flow/ui/components/payment_validation.dart';

void main() {
  test('Nombre y tarjeta deben tener contenido completo', () {
    expect(PaymentValidation.name('  '), isNotNull);
    expect(PaymentValidation.name('Al'), isNotNull);
    expect(PaymentValidation.name('Santiago'), isNull);
    expect(PaymentValidation.cardNumber('4111-1111'), isNotNull);
    expect(PaymentValidation.cardNumber('4111-1111-1111-1111'), isNull);
  });
  test(
    'Fecha valida formato, mes y vencimiento sin rechazar el mes actual',
    () {
      final now = DateTime(2026, 10, 21);
      expect(PaymentValidation.expiryDate('12/2', now: now), isNotNull);
      expect(PaymentValidation.expiryDate('00/28', now: now), isNotNull);
      expect(PaymentValidation.expiryDate('13/28', now: now), isNotNull);
      expect(PaymentValidation.expiryDate('09/26', now: now), isNotNull);
      expect(PaymentValidation.expiryDate('10/26', now: now), isNull);
      expect(PaymentValidation.expiryDate('12/28', now: now), isNull);
    },
  );
  test('CVV exige tres números', () {
    expect(PaymentValidation.cvv('12'), isNotNull);
    expect(PaymentValidation.cvv('abc'), isNotNull);
    expect(PaymentValidation.cvv('123'), isNull);
  });
}
