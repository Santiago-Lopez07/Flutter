import 'package:flutter/material.dart';
import 'package:flutter_screens/screen/second_secreen.dart';

class FirstScreen extends StatefulWidget {
  // Recibimos el mensaje desde la segunda pantalla
  // mediante el constructor.
  final String? messageFromSecondScreen;

  const FirstScreen({super.key, this.messageFromSecondScreen});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Primera pantalla')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Ingrese su nombre'),
            ),

            const SizedBox(height: 70),

            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  // Enviar datos mediante el constructor
                  // de la segunda pantalla.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(
                        messageFromFirstScreen: _controller.text,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, ingrese su nombre'),
                    ),
                  );
                }
              },
              child: const Text('Ir a la segunda pantalla'),
            ),

            // MENSAJE RECIBIDO DESDE LA SEGUNDA PANTALLA
            const SizedBox(height: 30),

            // OPERADOR SPREAD (...)
            // Permite agregar varios widgets a children.
            // Si el mensaje no es null, muestra los widgets.
            if (widget.messageFromSecondScreen != null) ...[
              const Text(
                'Mensaje regresado de la segunda ventana',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Text(
                widget.messageFromSecondScreen!,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
