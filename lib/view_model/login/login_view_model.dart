import 'package:flutter/material.dart';
import 'package:sebi_car/presentation/home/home_view.dart';
import 'package:sebi_car/service/auth_service.dart';
import 'package:sebi_car/ui_kit/error_or_success_dialog.dart';

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
    await _firebaseService.saveUserData(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    _isLoading = false;
    notifyListeners();
  }

  void saveAuthEmailAndPassword() async {
    _isLoading = true;
    notifyListeners();

    await _firebaseService.createEmailAndPssword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    _isLoading = false;
    notifyListeners();
  }

  void signInWithGoogle(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseService.singInWithGoogle();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    } catch (e) {
      showErrorDialog(e.toString(), context);
    }

    _isLoading = false;
    notifyListeners();
  }

  void signUpWithGoogle(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseService.signUpWithGoogle();
      await showSuccsesDialog(
          'Kayıt Başarılı bir şekilde gerçekleştirildi', context);
      _isLoading = false;
    } catch (e) {
      await showErrorDialog(e.toString(), context);

      return;
    }

    _isLoading = false;
    notifyListeners();
  }

  void signInCheckEmailAndPassword(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    await _firebaseService
        .signInWithEmailAndPassword(
      _loginNameController.text.trim(),
      _loginPasswordController.text.trim(),
    )
        .then(
      (user) {
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kullanıcı Girişi Başarısız'),
            ),
          );
        }
      },
    );
    _isLoading = false;
    notifyListeners();
  }
}
