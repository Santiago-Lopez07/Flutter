import 'package:flutter/material.dart';

import 'city.dart';

class MyAppSecond extends StatefulWidget {
  const MyAppSecond({super.key});

  @override
  State<MyAppSecond> createState() {
    return _MyAppSecondState();
  }
}

class _MyAppSecondState extends State<MyAppSecond> {
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
    'Atahualpa',
  ];

  @override
  void initState() {
    super.initState();
    print("Se ejecutó el evento: initState de la clase MyApp");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      title: "Aplicacion utilizando StatefulWidget",

      home: Scaffold(
        appBar: AppBar(title: const Text("Título del AppBar")),

        body: Stack(
          children: [
            // PRIMER LISTVIEW: ARRIBA A LA IZQUIERDA
            Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                height: 250,
                width: 250,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, position) {
                    return City(newCity: position.toString());
                  },
                ),
              ),
            ),

            // SEGUNDO LISTVIEW: ABAJO A LA DERECHA
            Positioned(
              bottom: 80,
              right: 10,
              child: SizedBox(
                height: 250,
                width: 150,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, position) {
                    return City(newCity: position.toString());
                  },
                ),
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              cities.add("Salinas");
            });

            print("Se ejecutó el evento: build");
            print("Numero de items: ${cities.length}");
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
