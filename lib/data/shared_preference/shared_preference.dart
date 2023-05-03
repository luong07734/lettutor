import 'dart:convert';

import 'package:lettutor/data/shared_preference/constants/shared_preference_keys.dart';
import 'package:lettutor/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  // shared pref instance
  static SharedPreference? _instance;

  static SharedPreference get instance {
    _instance ??= SharedPreference._();
    return _instance!;
  }

  // constructor
  SharedPreference._();

  Future<String?> get accessToken async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(SharedPreferenceKeys.accessToken);
  }

  Future<bool> saveAccessToken(String accessToken) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(
        SharedPreferenceKeys.accessToken, accessToken);
  }

  Future<bool> removeAccessToken() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.remove(SharedPreferenceKeys.accessToken);
  }

  Future<String?> get refreshToken async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(SharedPreferenceKeys.refreshToken);
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(
        SharedPreferenceKeys.refreshToken, refreshToken);
  }

  Future<bool> removeRefreshToken() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.remove(SharedPreferenceKeys.refreshToken);
  }

  Future<bool> saveCurrentLoggedUser(UserProfile currentLoggedUser) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    String userJson = jsonEncode(currentLoggedUser.toJson());
    return _sharedPreference.setString(
        SharedPreferenceKeys.currentLoggedUser, userJson);
  }

  Future<bool> removeCurrentLoggedUser() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.remove(SharedPreferenceKeys.currentLoggedUser);
  }

  Future<UserProfile?> get currentLoggedUser async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    if (_sharedPreference.getString(SharedPreferenceKeys.currentLoggedUser) ==
        null) {
      return null;
    } else {
      return UserProfile.fromJson(jsonDecode(_sharedPreference
          .getString(SharedPreferenceKeys.currentLoggedUser)!));
    }
  }

  Future<String?> get currentLanguage async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference
        .getString(SharedPreferenceKeys.currentLanguage);
  }

  Future<bool> saveCurrentLanguage(String currentLanguage) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(
        SharedPreferenceKeys.currentLanguage, currentLanguage);
  }

  Future<String?> get currentSpeechLanguage async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference
        .getString(SharedPreferenceKeys.currentSpeechLanguage);
  }

  Future<bool> saveCurrentSpeechLanguage(String currentSpeechLanguage) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(
        SharedPreferenceKeys.currentSpeechLanguage, currentSpeechLanguage);
  }

  Future<bool?> get isAutoTTS async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getBool(SharedPreferenceKeys.isAutoTTS);
  }

  Future<bool> saveIsAutoTTS(bool isAutoTTS) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setBool(SharedPreferenceKeys.isAutoTTS, isAutoTTS);
  }

  Future<bool?> get isDark async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getBool(SharedPreferenceKeys.isDark);
  }

  Future<bool> saveIsDark(bool isDark) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setBool(SharedPreferenceKeys.isDark, isDark);
  }
}
