import 'package:flutter/material.dart';

// Crear un Widget personalizado
class City extends StatelessWidget {
  const City({super.key, required this.newCity});

  final String newCity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(child: Center(child: Text(newCity))),

      onTap: () {
        print("Hizo click en el ítem: $newCity");
      },

      onDoubleTap: () {
        print("Hizo doble click en el ítem: $newCity");
      },

      onLongPress: () {
        print("Hizo click largo en el ítem: $newCity");
      },
    );
  }
}
