import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static late SharedPreferences _prefs;

  // Inisialisasi SharedPreferences
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Simpan status login
  static Future setLogin(bool value) async {
    await _prefs.setBool('isLogin', value);
  }

  // Ambil status login
  static bool get isLogin {
    return _prefs.getBool('isLogin') ?? false;
  }
}
