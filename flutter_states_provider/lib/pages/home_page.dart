import 'package:flutter/material.dart';
import 'package:flutter_states_provider/providers/theme_provider.dart';
import 'package:flutter_states_provider/providers/user_provider.dart';
import 'package:flutter_states_provider/providers/counter_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.select<CounterProvider, int>(
      (provider) => provider.counter,
    );

    final doubleCounter = context.select<CounterProvider, int>(
      (provider) => provider.doubleCounter,
    );

    final counterProvider = context.read<CounterProvider>();

    final userName = context.select<UserProvider, String>(
      (provider) => provider.userName,
    );

    final userProvider = context.read<UserProvider>();

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'Contador con: Provider-MultiProvider: $userName',
            style: const TextStyle(fontSize: 14),
            maxLines: 1,
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$counter Ha presionado el botón',
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 20),

              Text(
                '$counter',
                style: const TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text('Contador de 2 en 2', style: TextStyle(fontSize: 20)),

              Text(
                '$doubleCounter',
                style: const TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Incrementar ambos contadores
              Consumer<CounterProvider>(
                builder: (context, provider, child) => ElevatedButton(
                  onPressed: () {
                    provider.increment();
                    provider.incrementDouble();
                  },
                  child: const Text('Incrementar'),
                ),
              ),

              const SizedBox(height: 20),

              // Resetear ambos contadores
              ElevatedButton(
                onPressed: () {
                  counterProvider.reset();
                },
                child: const Text('Resetear'),
              ),

              const SizedBox(height: 20),

              // Decrementar ambos contadores
              Consumer<CounterProvider>(
                builder: (context, provider, child) => ElevatedButton(
                  onPressed: () {
                    provider.decrease();
                    provider.decreaseDouble();
                  },
                  child: const Text('Decrementar'),
                ),
              ),

              const SizedBox(height: 20),

              // Cambiar el título del AppBar
              ElevatedButton(
                onPressed: () {
                  userProvider.userName = 'Multiprovider';
                },
                child: const Text('Cambiar título del AppBar'),
              ),

              const SizedBox(height: 20),

              // Cambiar entre modo claro y modo oscuro
              ElevatedButton(
                onPressed: () {
                  //Modifica el tema
                  themeProvider.changeTheme();
                },
                child: Text(
                  themeProvider.themeMode == ThemeMode.light
                      ? 'Cambiar a Dark Mode'
                      : 'Cambiar a Light Mode',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
