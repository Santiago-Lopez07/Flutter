import 'package:flutter/material.dart';
import 'package:flutter_screens/screen/firts_screen.dart';

class SecondScreen extends StatefulWidget {
  final String messageFromFirstScreen;

  const SecondScreen({super.key, required this.messageFromFirstScreen});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segunda pantalla')),
      body: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          children: [
            const Text('Información enviada desde la primera pantalla'),

            const SizedBox(height: 20),

            Text(
              widget.messageFromFirstScreen,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 70),

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingrese un mensaje',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Método anterior con Navigator.pop:
                // Navigator.pop(context, _controller.text);

                // Método por constructor:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FirstScreen(messageFromSecondScreen: _controller.text),
                  ),
                );
              },
              child: const Text('Ingresar a la pantalla anterior'),
            ),
          ],
        ),
      ),
    );
  }
}
