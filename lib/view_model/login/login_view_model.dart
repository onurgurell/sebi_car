import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sebi_car/core/router/routes.dart';
import 'package:sebi_car/service/login_auth_service.dart';
import 'package:sebi_car/ui_kit/custom_snack_bar.dart';
import 'package:sebi_car/ui_kit/error_or_success_dialog.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginNameController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final LoginFirebaseService _firebaseService = LoginFirebaseService();
  final TextEditingController _fromWhereController = TextEditingController();
  final TextEditingController _toWhereController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordObscure = false;
  DateTime _selectedDate = DateTime.now();
  User? user = FirebaseAuth.instance.currentUser;

  DateTime get selectedDate => _selectedDate;
  TextEditingController get fromWhereController => _fromWhereController;
  TextEditingController get toWhereController => _toWhereController;
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get loginNameController => _loginNameController;
  TextEditingController get loginPasswordController => _loginPasswordController;
  bool get isLoading => _isLoading;
  bool get isPasswordObscure => _isPasswordObscure;

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void changeObscureText() {
    _isPasswordObscure = !_isPasswordObscure;
    notifyListeners();
  }

  void saveUserInfo() async {
    _isLoading = true;
    notifyListeners();
    if (user != null) {
      await _firebaseService.saveUserData(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        user!.uid,
      );
    } else {
      throw 'Kullanıcı kimliği bulunamadı.';
    }

    _isLoading = false;
    notifyListeners();
  }

  void saveUserPassangerInfo() async {
    _isLoading = true;
    notifyListeners();
    if (user != null) {
      _firebaseService.saveUserPassangerInfo(
        user!.uid,
        _fromWhereController.text,
        _toWhereController.text,
      );
    } else {
      throw 'Kullanıcı kimliği bulunamadı.';
    }

    _isLoading = false;
    notifyListeners();
  }

  void createAuthEmailAndPassword() async {
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

      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homePage, (Route<dynamic> route) => false);
    } catch (e) {
      showErrorDialog(e.toString(), context);
    }

    _isLoading = false;
    notifyListeners();
  }

  void signUpWithGoogle(BuildContext context) {
    _isLoading = true;
    notifyListeners();

    try {
      _firebaseService.signUpWithGoogle();
      showSuccsesDialog('Kayıt Başarılı bir şekilde gerçekleştirildi', context);
      _isLoading = false;
    } catch (e) {
      showErrorDialog(e.toString(), context);
      return;
    }

    _isLoading = false;
    notifyListeners();
  }

  void signInCheckEmailAndPassword(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _firebaseService
        .signInWithEmailAndPassword(
      _loginNameController.text.trim(),
      _loginPasswordController.text.trim(),
    )
        .then(
      (user) {
        if (user != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.homePage,
            (Route<dynamic> route) => false,
          );
        } else {
          customSnackBar('Kullanıcı Girişi Başarısız!!!', context);
        }
      },
    ).catchError((onError) {
      customSnackBar('Giriş Başarısız!!!', context);
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });

    _isLoading = false;
    notifyListeners();
  }
}
