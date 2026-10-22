import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'successful_screen.dart';
import '../components/payment_validation.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});
  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  final formKey = GlobalKey<FormState>();
  String name = '', cardNumber = '', expiryDate = '', cvvCode = '';
  bool savedCard = false;
  late final FocusNode cardNumberFocus, expiryDateFocus, cvvCodeFocus;
  final cardMask = MaskTextInputFormatter(
    mask: '####-####-####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );
  final expiryMask = MaskTextInputFormatter(
    mask: '##/##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  @override
  void initState() {
    super.initState();
    cardNumberFocus = FocusNode();
    expiryDateFocus = FocusNode();
    cvvCodeFocus = FocusNode();
  }

  @override
  void dispose() {
    cardNumberFocus.dispose();
    expiryDateFocus.dispose();
    cvvCodeFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const inputStyle = TextStyle(color: Colors.black, fontSize: 12);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              const Text(
                'Detalles de Pago',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.locationDot,
                    color: Color(0xff34495E),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: _progressLine(const Color(0xff34495E))),
                  const SizedBox(width: 10),
                  const FaIcon(
                    FontAwesomeIcons.creditCard,
                    color: Color(0xff34495E),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: _progressLine(const Color(0xff707070))),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/check_mark.png',
                    color: const Color(0xffD5D5D5),
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 10),
              Image.asset('assets/card_persons.png', height: 125),
              const SizedBox(height: 15),
              const Text(
                'Ingrese los datos de su tarjeta de crédito',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff6C738A),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: inputStyle,
                decoration: CustomInputDecoration('Nombre'),
                validator: PaymentValidation.name,
                onSaved: (value) => name = value!.trim(),
                textInputAction: TextInputAction.next,
                onEditingComplete: () => requestFocus(cardNumberFocus),
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: inputStyle,
                decoration: CustomInputDecoration('Número de tarjeta'),
                validator: PaymentValidation.cardNumber,
                onSaved: (value) => cardNumber = value!,
                inputFormatters: [cardMask],
                keyboardType: TextInputType.number,
                focusNode: cardNumberFocus,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => requestFocus(expiryDateFocus),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      style: inputStyle,
                      decoration: CustomInputDecoration('Fecha de expiración'),
                      inputFormatters: [expiryMask],
                      keyboardType: TextInputType.datetime,
                      validator: PaymentValidation.expiryDate,
                      onSaved: (value) => expiryDate = value!,
                      focusNode: expiryDateFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => requestFocus(cvvCodeFocus),
                    ),
                  ),
                  const Expanded(child: SizedBox(width: 20)),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      style: inputStyle,
                      decoration: CustomInputDecoration('CVV'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      keyboardType: TextInputType.number,
                      validator: PaymentValidation.cvv,
                      onSaved: (value) => cvvCode = value!,
                      focusNode: cvvCodeFocus,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => setState(() => savedCard = !savedCard),
                child: Row(
                  children: [
                    Checkbox(
                      value: savedCard,
                      onChanged: (value) =>
                          setState(() => savedCard = value ?? false),
                    ),
                    const Expanded(
                      child: Text('Guardar esta tarjeta para futuras compras?'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => showSuccessful(context),
                child: const Text('CONFIRMAR PAGO'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _progressLine(Color color) => Container(
    height: 4,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
  );
  void requestFocus(FocusNode focusNode) =>
      FocusScope.of(context).requestFocus(focusNode);
  void showSuccessful(BuildContext context) {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    FocusScope.of(context).unfocus();
    final myArguments = MyArguments(
      name: name,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cvvCode: cvvCode,
      savedCard: savedCard,
    );
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/payment_successful',
      ModalRoute.withName('/payment_successful'),
      arguments: myArguments,
    );
  }
}

class CustomInputDecoration extends InputDecoration {
  final String inputText;
  CustomInputDecoration(this.inputText)
    : super(
        filled: true,
        fillColor: const Color(0xffF5F5F5),
        hintText: inputText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(10),
      );
}
