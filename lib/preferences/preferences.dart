import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _nom = 'Esteve';
  static bool _isDarkMode = false;
  static List<String> _llistaTasques = [];

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get nom {
    return _prefs.getString('nom') ?? _nom;
  }

  static set nom(String value) {
    _nom = value;
    _prefs.setString('nom', value);
  }

  static bool get isDarkMode {
    return _prefs.getBool('darkmode') ?? _isDarkMode;
  }

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool('darkmode', value);
  }

  static List<String> get llistaTasques {
    return _prefs.getStringList('genere') ?? _llistaTasques;
  }

  static set llistaTasques(List<String> value) {
    _llistaTasques = value;
    _prefs.setStringList('genere', value);
  }
}
