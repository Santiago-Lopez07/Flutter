import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() {
    return _CounterScreenState();
  }
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  // Método para incrementar
  void _increase() {
    setState(() {
      _counter++;
    });
  }

  // Método para decrementar sin bajar de 0
  void _decrease() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  // Método para resetear el contador
  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contador con StatefulWidget")),

      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Ha presionado el botón:",
              style: TextStyle(fontSize: 25),
            ),

            const Spacer(flex: 2),

            Text(
              "$_counter",
              style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            // Botón incrementar
            ElevatedButton(
              onPressed: _increase,
              child: const Text("Incrementar"),
            ),

            const SizedBox(height: 15),

            // Botón decrementar
            ElevatedButton(
              onPressed: _decrease,
              child: const Text("Decrementar"),
            ),

            const SizedBox(height: 15),

            // Botón resetear
            ElevatedButton(onPressed: _reset, child: const Text("Resetear")),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
