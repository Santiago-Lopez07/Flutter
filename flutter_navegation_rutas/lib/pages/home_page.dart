import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagina 1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //print('Boton presionado');
            Navigator.pushNamed(context, '/secondPage');
          },
          child: const Text('Mostrar pagina 2'),
        ),
      ),
    );
  }
}
