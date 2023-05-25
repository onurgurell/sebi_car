import 'package:flutter/material.dart';
import 'package:sebi_car/model/user_model.dart';
import 'package:sebi_car/service/auth_service.dart';
import 'package:sebi_car/view_model/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JourneyCreationViewModel extends BaseViewModel {
  JourneyCreationViewModel() {
    init();
  }
  final TextEditingController _forDriverFromWhere = TextEditingController();
  final TextEditingController _forDriverToWhere = TextEditingController();
  final TextEditingController _forDriverPrice = TextEditingController();
  DateTime _driverSelectedCal = DateTime.now();
  TimeOfDay _driverSelectedTime = TimeOfDay.now();
  final FirebaseService _firebaseService = FirebaseService();
  late SharedPreferences sharedPreferences;

  DateTime get driverSelectedCal => _driverSelectedCal;
  TimeOfDay get driverSelectedTime => _driverSelectedTime;
  TextEditingController get forDriverFromWhere => _forDriverFromWhere;
  TextEditingController get forDriverToWhere => _forDriverToWhere;
  TextEditingController get forDriverPrice => _forDriverPrice;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void driverSelectedCalender(DateTime date) {
    _driverSelectedCal = date;
    notifyListeners();
  }

  void driverSelectedChooseTime(DateTime time) {
    final selectedTime = TimeOfDay.fromDateTime(time);
    _driverSelectedTime = selectedTime;
    notifyListeners();
  }

  Future<void> saveDriverInfo() async {
    if (user != null) {
      String? cachedUserId = sharedPreferences.getString('userId');
      UserModel userData = await _firebaseService.getUserData(cachedUserId!);
      final userName = userData.name;

      String selectedTimeFormatted = formatTime(_driverSelectedTime);

      _firebaseService.authSaveDriverInfo(
        userName,
        _forDriverFromWhere.text,
        _forDriverToWhere.text,
        _driverSelectedCal,
        selectedTimeFormatted,
        _forDriverPrice.text,
      );
    } else {
      throw 'Kullanıcı kimliği bulunamadı.';
    }

    notifyListeners();
  }

  String formatTime(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
