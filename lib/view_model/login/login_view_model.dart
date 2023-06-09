import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sebi_car/core/local/shared_prefs.dart';
import 'package:sebi_car/core/router/routes.dart';
import 'package:sebi_car/service/auth_service.dart';
import 'package:sebi_car/ui_kit/custom_snack_bar.dart';
import 'package:sebi_car/ui_kit/error_or_success_dialog.dart';
import 'package:sebi_car/view_model/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel() {}
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginNameController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  bool _isLoading = false;
  bool _isPasswordObscure = false;

  final SharedPrefs pref = SharedPrefs();

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get loginNameController => _loginNameController;
  TextEditingController get loginPasswordController => _loginPasswordController;
  bool get isLoading => _isLoading;
  bool get isPasswordObscure => _isPasswordObscure;

  void loadingFunc() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void changeObscureText() {
    _isPasswordObscure = !_isPasswordObscure;
    notifyListeners();
  }

  void saveUserInfo() async {
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

    await pref.save("userId", user!.uid);
  }

  Future<void> createEmailAndPassword() async {
    try {
      await _firebaseService.authCreateEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          throw 'Bu Email Mevcut';
        } else {
          throw 'Hata Oluştu';
        }
      } else {
        throw 'Kayıt Başarısız';
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    loadingFunc();

    try {
      await _firebaseService.authSignInWithGoogle();

      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homePage, (Route<dynamic> route) => false);
    } catch (e) {
      showSuccessOrErrorDialog('Error', e.toString(), context);
    }

    loadingFunc();
    return;
  }

  Future<void> signUpWithGoogle(BuildContext context) async {
    loadingFunc();

    try {
      await _firebaseService.authSignUpWithGoogle();
      showSuccessOrErrorDialog(
          'Başarılı', 'Kayıt Başarılı Şekilde Oluşturuldu', context);
    } catch (e) {
      showSuccessOrErrorDialog('Error', e.toString(), context);
      loadingFunc();

      return;
    }

    loadingFunc();
    return;
  }

  Future<void> signInCheckEmailAndPassword(BuildContext context) async {
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
    ).catchError((e) {
      customSnackBar(e.toString(), context);
    });
  }
}
