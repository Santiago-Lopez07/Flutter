/// Validaciones locales del formulario de la práctica; no realizan un cobro.
class PaymentValidation {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ingrese el nombre';
    if (value.trim().length < 3) return 'Ingrese al menos 3 caracteres';
    return null;
  }

  static String? cardNumber(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese el número de tarjeta';
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length != 16) return 'Ingrese los 16 dígitos de la tarjeta';
    return null;
  }

  static String? expiryDate(String? value, {DateTime? now}) {
    if (value == null || value.isEmpty) return 'Ingrese la fecha de expiración';
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) return 'Use MM/AA';
    final month = int.parse(value.substring(0, 2));
    final year = 2000 + int.parse(value.substring(3));
    if (month < 1 || month > 12) return 'Mes inválido';
    final today = now ?? DateTime.now();
    if (year < today.year || (year == today.year && month < today.month)) {
      return 'Tarjeta vencida';
    }
    return null;
  }

  static String? cvv(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese el código cvv';
    if (!RegExp(r'^\d{3}$').hasMatch(value)) return 'Ingrese 3 dígitos';
    return null;
  }
}
