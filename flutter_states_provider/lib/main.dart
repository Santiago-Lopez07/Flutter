import 'package:flutter/material.dart';
import 'package:flutter_states_provider/pages/home_page.dart';
import 'package:flutter_states_provider/providers/user_provider.dart';
import 'package:flutter_states_provider/providers/counter_provider.dart';
import 'package:flutter_states_provider/providers/theme_provider.dart';
import 'package:provider/provider.dart';

// void main() => runApp(const MyApp());

void main() {
  runApp(
    // MÉTODO NUEVO: MultiProvider
    // Permite utilizar varios proveedores al mismo tiempo.
    MultiProvider(
      providers: [
        // Proveedor del contador
        ChangeNotifierProvider(create: (_) => CounterProvider()),

        // Proveedor del usuario
        ChangeNotifierProvider(create: (_) => UserProvider()),

        // Proveedor del tema
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador con el gestor/proveedor de estados: Provider',

      // TEMA CLARO
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: false,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
          ),
        ),
      ),

      // TEMA OSCURO
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: false,

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF263238),
          foregroundColor: Colors.white,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF455A64),
            foregroundColor: Colors.white,
          ),
        ),
      ),

      // Aplicar el tema seleccionado
      themeMode: themeProvider.themeMode,

      home: const HomePage(),
    );
  }
}
