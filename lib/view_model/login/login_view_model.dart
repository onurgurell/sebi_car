import 'package:flutter/material.dart';
import 'package:sebi_car/core/router/routes.dart';
import 'package:sebi_car/service/auth_service.dart';
import 'package:sebi_car/ui_kit/custom_snack_bar.dart';
import 'package:sebi_car/ui_kit/error_or_success_dialog.dart';
import 'package:sebi_car/view_model/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel() {
    init();
  }
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginNameController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  bool _isLoading = false;
  bool _isPasswordObscure = false;

  late SharedPreferences sharedPreferences;

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get loginNameController => _loginNameController;
  TextEditingController get loginPasswordController => _loginPasswordController;
  bool get isLoading => _isLoading;
  bool get isPasswordObscure => _isPasswordObscure;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void changeObscureText() {
    _isPasswordObscure = !_isPasswordObscure;
    notifyListeners();
  }

  void saveUserInfo() async {
    _isLoading = true;
    notifyListeners();
    if (user != null) {
      await _firebaseService.authSaveUserData(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        user!.uid,
      );
    } else {
      throw 'Kullanıcı kimliği bulunamadı.';
    }
    await sharedPreferences.setString('userId', user!.uid);

    _isLoading = false;
    notifyListeners();
  }

  void createAuthEmailAndPassword() async {
    _isLoading = true;
    notifyListeners();

    await _firebaseService.authCreateEmailAndPssword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseService.authSignInWithGoogle();

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
      _firebaseService.authSignUpWithGoogle();
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
        .authSignInWithEmailAndPassword(
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
