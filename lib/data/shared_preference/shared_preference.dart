import 'package:lettutor/data/shared_preference/constants/shared_preference_keys.dart';
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
    return _sharedPreference.setString(SharedPreferenceKeys.accessToken, accessToken);
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(SharedPreferenceKeys.refreshToken, refreshToken);
  }

  Future<bool> removeRefreshToken() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();

    return _sharedPreference.remove(SharedPreferenceKeys.refreshToken);
  }
}
