import 'package:shared_preferences/shared_preferences.dart';

class Constants{
  static SharedPreferences prefs;
  static const String loggedInPrefKey = "loggedIn";
  static const String barcodeResultPrefKey = "barcodeResult";
  static const String usernamePrefKey = "username";
  static const String passwordPrefKey = "password";
  
}