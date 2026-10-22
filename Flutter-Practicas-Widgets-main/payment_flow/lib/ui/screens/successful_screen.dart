import 'package:flutter/material.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    assert(arguments == null || arguments is MyArguments);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xff34495E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Center(
                child: Image.asset('assets/woman.png', height: 200),
              ),
            ),
            const SizedBox(height: 30),
            Image.asset('assets/done.png', height: 60),
            const SizedBox(height: 30),
            const Text(
              'Gracias por su compra',
              style: TextStyle(
                color: Color(0xff34495E),
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            const Text(
              'Su orden será entregada en \n 2-4 días laborables.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => _continueShopping(context),
        child: const Text('CONTINUAR COMPRANDO'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Inicia otra compra sin recuperar el formulario del pago anterior.
  void _continueShopping(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }
}

class MyArguments {
  final String name, cardNumber, expiryDate, cvvCode;
  final bool savedCard;
  const MyArguments({
    required this.name,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvvCode,
    required this.savedCard,
  });
  @override
  String toString() =>
      'MyArguments(name: $name, cardNumber: $cardNumber, expiryDate: $expiryDate, cvvCode: $cvvCode, savedCard: $savedCard)';
}
