import 'package:flutter/material.dart';
import 'package:sebi_car/service/auth_service.dart';
import 'package:sebi_car/view_model/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchAreaViewModel extends BaseViewModel {
  SearchAreaViewModel() {
    init();
  }
  final TextEditingController _fromWhereController = TextEditingController();
  final TextEditingController _toWhereController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  final List<Map<String, dynamic>> _searchResult = [];
  late SharedPreferences sharedPreferences;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  DateTime get selectedDate => _selectedDate;
  TextEditingController get fromWhereController => _fromWhereController;
  TextEditingController get toWhereController => _toWhereController;
  List<Map<String, dynamic>> get searchResult => _searchResult;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> savePassangerInfo() async {
    _isLoading = true;
    notifyListeners();
    if (user != null) {
      String? cachedUserId = sharedPreferences.getString('userId');
      _firebaseService.authSavePassangerInfo(
        cachedUserId!,
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

  Future<void> searchTravel() async {
    try {
      final searchResultList = await _firebaseService.authSearchTravel(
        _fromWhereController.text.trim(),
        _toWhereController.text.trim(),
        _selectedDate,
      );
      final documents = searchResultList;

      for (final document in documents.docs) {
        final driverToWhere = document['toWhere'];
        final driverFromWhere = document['fromWhere'];
        final price = document['price'];
        final driverSelectedTime = document['selectedTime'];
        final driverName = document['name'];
        print("name $driverName");

        _searchResult.add({
          'toWhere': driverToWhere,
          'fromWhere': driverFromWhere,
          'price': price,
          'selectedTime': driverSelectedTime,
          'name': driverName,
        });
      }
      print("length  ${_searchResult.length}");

      print("aaaa $_searchResult");

      notifyListeners();
    } catch (e) {
      throw "sonuç başarısız!!!!! ${e.toString()}";
    }
  }
}
