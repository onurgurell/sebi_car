import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<String?> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key)!;
  }

  Future<void> save(String key, value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }
}
