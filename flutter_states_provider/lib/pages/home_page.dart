import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_states_provider/providers/counter_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = context.watch<CounterProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Contador con: Provider')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mostrar el contador usando context.watch
            Text(
              '${context.watch<CounterProvider>().counter} Ha presionado el botón',
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            // Contador que aumenta de 1 en 1
            Text(
              '${counterProvider.counter}',
              style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Segundo contador que aumenta de 2 en 2
            const Text('Contador de 2 en 2', style: TextStyle(fontSize: 20)),

            Text(
              '${counterProvider.doubleCounter}',
              style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Incrementar ambos contadores
            ElevatedButton(
              onPressed: () {
                context.read<CounterProvider>().increment();
                context.read<CounterProvider>().incrementDouble();
              },
              child: const Text('Incrementar'),
            ),

            const SizedBox(height: 20),

            // Resetear ambos contadores
            ElevatedButton(
              onPressed: () => context.read<CounterProvider>().reset(),
              child: const Text('Resetear'),
            ),

            const SizedBox(height: 20),

            // Decrementar ambos contadores
            ElevatedButton(
              onPressed: () {
                context.read<CounterProvider>().decrease();
                context.read<CounterProvider>().decreaseDouble();
              },
              child: const Text('Decrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
