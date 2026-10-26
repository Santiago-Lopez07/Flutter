import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_states_provider/providers/counter_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // MÉTODO ANTERIOR: context.watch()
    // final counterProvider = context.watch<CounterProvider>();

    // MÉTODO ANTERIOR: context.read()
    // final provider = context.read<CounterProvider>();

    // MÉTODO ANTERIOR: Provider.of()
    // final provider = Provider.of<CounterProvider>(context);

    // COMBINAR context.select() CON Consumer

    // Seleccionar solamente el contador de 1 en 1
    final counter = context.select<CounterProvider, int>(
      (provider) => provider.counter,
    );

    // Seleccionar solamente el contador de 2 en 2
    final doubleCounter = context.select<CounterProvider, int>(
      (provider) => provider.doubleCounter,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Contador con: Provider')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MÉTODO ANTERIOR: context.watch()
            // Text(
            //   '${context.watch<CounterProvider>().counter} Ha presionado el botón',
            //   style: const TextStyle(fontSize: 20),
            // ),

            // MÉTODO NUEVO: context.select()
            Text(
              '$counter Ha presionado el botón',
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            // Contador que aumenta de 1 en 1

            // MÉTODO ANTERIOR: Provider.of()
            // Text('${provider.counter}'),

            // MÉTODO ANTERIOR: Consumer
            // Consumer<CounterProvider>(
            //   builder: (context, provider, _) => Text(
            //     '${provider.counter}',
            //   ),
            // ),

            // MÉTODO NUEVO: context.select()
            Text(
              '$counter',
              style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Segundo contador que aumenta de 2 en 2
            const Text('Contador de 2 en 2', style: TextStyle(fontSize: 20)),

            // MÉTODO ANTERIOR: Consumer
            // Consumer<CounterProvider>(
            //   builder: (context, provider, _) => Text(
            //     '${provider.doubleCounter}',
            //   ),
            // ),

            // MÉTODO NUEVO: context.select()
            Text(
              '$doubleCounter',
              style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Incrementar ambos contadores utilizando Consumer
            Consumer<CounterProvider>(
              builder: (context, provider, child) => ElevatedButton(
                onPressed: () {
                  // Incrementar de 1 en 1
                  provider.increment();

                  // Incrementar de 2 en 2
                  provider.incrementDouble();
                },
                child: const Text('Incrementar'),
              ),
            ),

            const SizedBox(height: 20),

            // Resetear ambos contadores utilizando Consumer
            Consumer<CounterProvider>(
              builder: (context, provider, child) => ElevatedButton(
                onPressed: () {
                  provider.reset();
                },
                child: const Text('Resetear'),
              ),
            ),

            const SizedBox(height: 20),

            // Decrementar ambos contadores utilizando Consumer
            Consumer<CounterProvider>(
              builder: (context, provider, child) => ElevatedButton(
                onPressed: () {
                  // Decrementar de 1 en 1
                  provider.decrease();

                  // Decrementar de 2 en 2
                  provider.decreaseDouble();
                },
                child: const Text('Decrementar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
