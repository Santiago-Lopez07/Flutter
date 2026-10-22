import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/payment_type.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethodScreen> {
  PaymentMethod paymentSelected = PaymentMethod.creditCard;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Método de pago',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff1A1A1A),
            ),
          ),
          const Text(
            'Seleccione uno de los métodos de pago',
            style: TextStyle(fontSize: 12, color: Color(0xff6C738A)),
          ),
          const SizedBox(height: 20),
          PaymentMethodWidget(
            icon: const FaIcon(
              FontAwesomeIcons.creditCard,
              color: Color(0xffCCB375),
            ),
            title: 'Tarjeta de crédito',
            subTitle: 'Pague con Mastercard o Visa',
            value: PaymentMethod.creditCard,
            selectedValue: paymentSelected,
            paymentCallBack: onPaymentChange,
          ),
          PaymentMethodWidget(
            icon: const FaIcon(
              FontAwesomeIcons.buildingColumns,
              color: Color(0xff00A7D9),
            ),
            title: 'Transferencia bancaria',
            subTitle: 'Pague directo desde su cuenta',
            value: PaymentMethod.bank,
            selectedValue: paymentSelected,
            paymentCallBack: onPaymentChange,
          ),
          PaymentMethodWidget(
            icon: const FaIcon(
              FontAwesomeIcons.paypal,
              color: Color(0xff0D47A1),
            ),
            title: 'Paypal',
            subTitle: 'La forma más rápida y segura de enviar dinero',
            value: PaymentMethod.paypal,
            selectedValue: paymentSelected,
            paymentCallBack: onPaymentChange,
          ),
          PaymentMethodWidget(
            icon: const FaIcon(FontAwesomeIcons.bitcoin, color: Colors.black),
            title: 'Billetera de bitcoin',
            subTitle: 'Enviar la cantidad a nuestra billetera Bitcoin',
            value: PaymentMethod.bitcoin,
            selectedValue: paymentSelected,
            paymentCallBack: onPaymentChange,
          ),
        ],
      ),
    ),
    floatingActionButton: ElevatedButton(
      onPressed: () => showDetails(context),
      child: const Text('SIGUIENTE'),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  );
  void onPaymentChange(PaymentMethod value) =>
      setState(() => paymentSelected = value);
  void showDetails(BuildContext context) =>
      Navigator.pushNamed(context, '/payment_details');
}
