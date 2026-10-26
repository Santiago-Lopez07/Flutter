import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _userName = "Invitado";

  //Lectura
  String get userName {
    return _userName;
  }

  //escritura
  set userName(String userName) {
    _userName = userName;
    notifyListeners();
  }
}
