import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorage {
  Future<void> initialise();
  Future<bool> setString(String key, String value);
  String? getString(String key);
  bool containsKey(String key);
  Future<bool> remove(String key);
}

class LocalStorage implements ILocalStorage {
  late SharedPreferences _prefs;

  @override
  Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  @override
  String? getString(String key) {
    return _prefs.getString(key);
  }

  @override
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  @override
  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }
}
