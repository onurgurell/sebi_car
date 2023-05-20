import 'package:flutter/material.dart';
import 'package:sebi_car/service/home_auth_service.dart';

class HomeViewModel extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _fromWhereController = TextEditingController();
  final TextEditingController _toWhereController = TextEditingController();
  final HomeFirebaseService _firebaseService = HomeFirebaseService();

  DateTime get selectedDate => _selectedDate;
  TextEditingController get fromWhereController => _fromWhereController;
  TextEditingController get toWhereController => _toWhereController;

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  // void saveUserPassangerInfo() async {
  //   _firebaseService.saveUserPassangerInfo(
  //     _fromWhereController.text,
  //     _toWhereController.text,
  //   );
  //   notifyListeners();
  // }
}
