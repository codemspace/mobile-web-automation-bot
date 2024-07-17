import 'package:flutter/material.dart';

class LoginState with ChangeNotifier {
  int _loginAttempts = 0;

  int get loginAttempts => _loginAttempts;

  void incrementAttempts() {
    _loginAttempts++;
    notifyListeners();
  }

  void resetAttempts() {
    _loginAttempts = 0;
    notifyListeners();
  }
}
