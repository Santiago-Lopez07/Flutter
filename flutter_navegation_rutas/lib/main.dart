import 'package:flutter/material.dart';
import 'package:flutter_navegation_rutas/pages/home_page.dart';
import 'package:flutter_navegation_rutas/pages/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegación y rutas en Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/secondPage': (context) => const SecondPage(),
      },
    );
  }
}
