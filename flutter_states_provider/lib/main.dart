import 'package:flutter/material.dart';
import 'package:flutter_states_provider/pages/home_page.dart';
import 'package:flutter_states_provider/providers/counter_provider.dart';
import 'package:provider/provider.dart';

//void main() => runApp(const MyApp());
void main() {
  runApp(
    //Crear una nueva instancia de la clase: CointerProvider que gestoina el estado
    //Esta clase se guarda internamente en el arbol de widgets para que luego para queluego se pueda
    //acceder por los widgets hijos usando: counter.watch
    //Utilizar la  clase ChangeNotifierProvider para compartir el estado con los widgets del proyecto

    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador con el gestor/proveedor de estados: Provider',
      theme: ThemeData(primarySwatch: Colors.amber, useMaterial3: false),
      home: const HomePage(),
    );
  }
}
