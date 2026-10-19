import 'package:flutter/material.dart';
import 'package:flutter_screens/screen/firts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paso de parámetros entre ventanas',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: const FirstScreen(),
    );
  }
}
