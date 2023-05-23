import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sebi_car/core/router/routes.dart';
import 'package:sebi_car/service/auth_service.dart';
import 'package:sebi_car/ui_kit/custom_snack_bar.dart';
import 'package:sebi_car/ui_kit/error_or_success_dialog.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginNameController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _fromWhereController = TextEditingController();
  final TextEditingController _toWhereController = TextEditingController();
  final TextEditingController _forDriverFromWhere = TextEditingController();
  final TextEditingController _forDriverToWhere = TextEditingController();
  final TextEditingController _forDriverPrice = TextEditingController();
  DateTime _driverSelectedCal = DateTime.now();
  DateTime _driverSelectedTime = DateTime.now();
  bool _isLoading = false;
  bool _isPasswordObscure = false;
  DateTime _selectedDate = DateTime.now();
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> _searchResult = [];

  DateTime get driverSelectedCal => _driverSelectedCal;
  DateTime get driverSelectedTime => _driverSelectedTime;
  TextEditingController get forDriverFromWhere => _forDriverFromWhere;
  TextEditingController get forDriverToWhere => _forDriverToWhere;
  TextEditingController get forDriverPrice => _forDriverPrice;
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
  List<Map<String, dynamic>> get searchResult => _searchResult;

  void driverSelectedCalender(DateTime date) {
    _driverSelectedCal = date;
    notifyListeners();
  }

  void driverSelectedChooseTime(DateTime time) {
    _driverSelectedTime = time;
    notifyListeners();
  }

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

  Future<void> savePassangerInfo() async {
    _isLoading = true;
    notifyListeners();
    if (user != null) {
      _firebaseService.savePassangerInfo(
        user!.uid,
        _fromWhereController.text,
        _toWhereController.text,
        _selectedDate,
      );
    } else {
      throw 'Kullanıcı kimliği bulunamadı.';
    }

    _isLoading = false;
    notifyListeners();
  }

  void saveDriverInfo() async {
    notifyListeners();
    if (user != null) {
      _firebaseService.saveDriverInfo(
        user!.uid,
        user!.displayName.toString(),
        _forDriverFromWhere.text,
        _forDriverToWhere.text,
        _driverSelectedCal,
        _driverSelectedTime,
        _forDriverPrice.text,
      );
    } else {
      throw 'Kullanıcı kimliği bulunamadı.';
    }

    notifyListeners();
  }

  Future<void> searchDrivers() async {
    try {
      final searchResultList = await _firebaseService.searchTravel(
        _fromWhereController.text.trim(),
        _toWhereController.text.trim(),
        _selectedDate,
      );

      final documents = searchResultList;

      for (final document in documents.docs) {
        final driverToWhere = document['toWhere'];
        final driverFromWhere = document['fromWhere'];
        final price = document['price'];
        final driverSelectedCal = document['selectedCalender'];

        _searchResult.add({
          'toWhere': driverToWhere,
          'fromWhere': driverFromWhere,
          'price': price,
          'selectedCalender': driverSelectedCal,
        });
      }

      print("search result: $_searchResult");
      notifyListeners();
    } catch (e) {
      throw "sonuç başarısız!!!!! ${e.toString()}";
    }
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
