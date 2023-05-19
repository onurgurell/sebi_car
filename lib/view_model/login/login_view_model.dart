import 'package:flutter/material.dart';
import 'package:sebi_car/service/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginNameController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  bool _isLoading = false;
  bool _isPasswordObscure = false;

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get loginNameController => _loginNameController;
  TextEditingController get loginPasswordController => _loginPasswordController;
  bool get isLoading => _isLoading;
  bool get isPasswordObscure => _isPasswordObscure;

  void changeObscureText() {
    _isPasswordObscure = !_isPasswordObscure;
    notifyListeners();
  }

  void saveUserInfo() async {
    _isLoading = true;
    notifyListeners();
    _firebaseService.saveUserData(
      _nameController,
      _emailController,
      _passwordController,
    );

    _isLoading = false;
    notifyListeners();
  }
}
