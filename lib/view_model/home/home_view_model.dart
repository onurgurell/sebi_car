import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sebi_car/service/auth_service.dart';

class HomeViewModel extends ChangeNotifier {
  DateTime _driverSelectedCal = DateTime.now();
  DateTime _driverSelectedTime = DateTime.now();
  TextEditingController _forDriverFromWhere = TextEditingController();
  TextEditingController _forDriverToWhere = TextEditingController();
  TextEditingController _forDriverPrice = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  User? user = FirebaseAuth.instance.currentUser;

  DateTime get driverSelectedCal => _driverSelectedCal;
  DateTime get driverSelectedTime => _driverSelectedTime;
  TextEditingController get forDriverFromWhere => _forDriverFromWhere;
  TextEditingController get forDriverToWhere => _forDriverToWhere;
  TextEditingController get forDriverPrice => _forDriverPrice;

  void driverSelectedCalender(DateTime date) {
    _driverSelectedCal = date;
    notifyListeners();
  }

  void driverSelectedChooseTime(DateTime time) {
    _driverSelectedTime = time;
    notifyListeners();
  }

  // void saveDriverInfo() async {
  //   notifyListeners();
  //   if (user != null) {
  //     _firebaseService.saveDriverInfo(
  //       user!.uid,
  //       _forDriverFromWhere.text,
  //       _forDriverToWhere.text,
  //       _driverSelectedCal,
  //       _driverSelectedTime,
  //       _forDriverPrice.text,
  //     );
  //   } else {
  //     throw 'Kullanıcı kimliği bulunamadı.';
  //   }

  //   notifyListeners();
  // }
}
