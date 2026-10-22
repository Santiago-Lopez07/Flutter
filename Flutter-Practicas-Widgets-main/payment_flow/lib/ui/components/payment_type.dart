import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PaymentMethod { creditCard, bank, paypal, bitcoin }

typedef PaymentCallBack = void Function(PaymentMethod value);

class PaymentMethodWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subTitle;
  final PaymentMethod value;
  final PaymentMethod selectedValue;
  final PaymentCallBack paymentCallBack;
  const PaymentMethodWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.selectedValue,
    required this.paymentCallBack,
  });
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 15),
    child: Semantics(
      selected: value == selectedValue,
      button: true,
      child: InkWell(
        onTap: _onTap,
        borderRadius: BorderRadius.circular(25),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: getWidgetState(),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffFBFBFB),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            subTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xff6C738A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  Widget getWidgetState() {
    if (value == selectedValue) {
      return const FaIcon(
        FontAwesomeIcons.solidCircleCheck,
        color: Colors.green,
        size: 20,
      );
    }
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 2),
      ),
    );
  }

  void _onTap() => paymentCallBack(value);
}
