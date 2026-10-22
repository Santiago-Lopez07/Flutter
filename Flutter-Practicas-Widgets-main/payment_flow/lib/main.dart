import 'package:flutter/material.dart';

import 'ui/screens/payment_method_screen.dart';
import 'ui/screens/payment_details_screen.dart';
import 'ui/screens/successful_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flujo de pago',
    initialRoute: '/',
    routes: {
      '/': (context) => const PaymentMethodScreen(),
      '/payment_details': (context) => const PaymentDetailsScreen(),
      '/payment_successful': (context) => const SuccessfulScreen(),
    },
    theme: ThemeData(
      useMaterial3: false,
      fontFamily: 'Montserrat',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff050060)),
      ),
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff34495E),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: const TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
    ),
  );
}
