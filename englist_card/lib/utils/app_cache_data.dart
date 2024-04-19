import 'package:shared_preferences/shared_preferences.dart';

class AppCacheData{
  static const String _counter = 'counter';
  static Future<void> setCounterToCache(String counter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_counter, counter);
  }

  static Future<String?> getCounterToCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_counter);
  }
}