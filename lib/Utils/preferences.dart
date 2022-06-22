import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Model/otp_verification_model.dart';



class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool?>? putObject(String key, Object value) async {
    var prefs = await _instance;

    if (prefs == null) return null;
    return prefs.setString(key, json.encode(value));
  }

  static Future<OtpVerificationModel?> getDataObject(String key) async {
    var prefs = await _instance;
    String? _data = prefs.getString(key);
    return (_data == null || _data.isEmpty) ? null : OtpVerificationModel.fromJson(jsonDecode(_data));
  }

 /* static Future<SocialSignUpModel?> getSocialLoginObject(String key) async {
    var prefs = await _instance;
    String? _data = prefs.getString(key);
    return (_data == null || _data.isEmpty) ? null : SocialSignUpModel.fromJson(jsonDecode(_data));
  }
*/
  ///clear
  static Future<bool>? clear() {
    if (_prefsInstance == null) return null;
    return _prefsInstance!.clear();
  }
}
