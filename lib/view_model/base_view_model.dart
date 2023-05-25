import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;

  void setUser(User? newUser) {
    user = newUser;
    notifyListeners();
  }
}
