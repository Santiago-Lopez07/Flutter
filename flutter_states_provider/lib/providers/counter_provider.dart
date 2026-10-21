import 'package:flutter/material.dart';

// ChangeNotifier permite notificar a los widgets
// cuando el estado cambia.

// La clase CounterController utiliza el patrón Observer
// mediante ChangeNotifier.

// Esta clase extiende ChangeNotifier
class CounterProvider with ChangeNotifier {
  // Variables que contienen el estado
  int _counter = 0;
  int _doubleCounter = 0;

  // Propiedad de lectura
  // int get counter() {
  //   return _counter;
  // }

  int get counter => _counter;

  // Getter del segundo contador
  int get doubleCounter => _doubleCounter;

  // Propiedad de escritura
  // set counter(int value) {
  //   _counter = value;
  // }

  void increment() {
    _counter++;

    // Este método permite que el widget que tenga
    // el método context.watch() se actualice cuando
    // el proveedor notifica a sus oyentes (listeners).
    //
    // Por ejemplo, al llamar al método notifyListeners(),
    // se notifica a los widgets que están escuchando
    // los cambios del contador.

    notifyListeners();
  }

  // Incrementar el segundo contador de 2 en 2
  void incrementDouble() {
    _doubleCounter += 2;
    notifyListeners();
  }

  void reset() {
    _counter = 0;
    _doubleCounter = 0;
    notifyListeners();
  }

  // Método para decrementar el contador
  // No permite valores negativos
  void decrease() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  // Decrementar el segundo contador de 2 en 2
  // No permite valores negativos
  void decreaseDouble() {
    if (_doubleCounter >= 2) {
      _doubleCounter -= 2;
      notifyListeners();
    }
  }
}
