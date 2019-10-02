import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final keyEmail = 'email';

  static Future saveEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(keyEmail, value);
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyEmail);
  }
}
