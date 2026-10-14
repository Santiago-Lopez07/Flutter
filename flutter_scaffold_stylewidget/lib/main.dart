import 'package:flutter/material.dart';
import 'package:flutter_scaffold_stylewidget/myapp_second.dart';

import 'city.dart';

void main() {
  //runApp(MyApp());
  runApp(MyAppSecond());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  final List<String> cities = [
    'Ambato',
    'Guayaquil',
    'Ibarra',
    'Latacunga',
    'Riobamba',
    'Baños',
    'Patate',
    'Quero',
    'Loja',
    'Cuenca',
    'Manta',
    'Portoviejo',
    'Tena',
    'Puyo',
    'Zamora',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      title: "Aplicacion utilizando StatelessWidget",
      home: Scaffold(
        appBar: AppBar(title: const Text("Título del AppBar")),

        body: Column(
          children: cities.map((item) => City(newCity: item)).toList(),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Numero de items: ${cities.length}");
            cities.add("Salinas");
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
