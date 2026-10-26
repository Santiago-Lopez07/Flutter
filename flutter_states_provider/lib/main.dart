import 'package:flutter/material.dart';
import 'package:flutter_states_provider/pages/home_page.dart';
import 'package:flutter_states_provider/pages/user_provider.dart';
import 'package:flutter_states_provider/providers/counter_provider.dart';
import 'package:provider/provider.dart';

// void main() => runApp(const MyApp());

void main() {
  runApp(
    // Crear una nueva instancia de la clase CounterProvider
    // que gestiona el estado.
    // Esta clase se guarda internamente en el árbol de widgets
    // para que luego los widgets hijos puedan acceder a ella.
    // Utilizar ChangeNotifierProvider para compartir el estado.

    // MÉTODO ANTERIOR: ChangeNotifierProvider
    /*
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const MyApp(),
    ),
    */

    // MÉTODO NUEVO: MultiProvider
    // Permite utilizar varios proveedores al mismo tiempo.
    MultiProvider(
      providers: [
        // Proveedor del contador
        ChangeNotifierProvider(create: (_) => CounterProvider()),

        // Proveedor del usuario
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],

      // Widget principal de la aplicación
      child: const MyApp(),
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
