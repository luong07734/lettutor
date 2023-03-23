import 'package:flutter/material.dart';
import 'package:lettutor/data/network/apis/authentication/authentication_apis.dart';
import 'package:lettutor/data/shared_preference/shared_preference.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationApi _authApi = AuthenticationApi();
  String? emailSave, passwordSave;

  void saveAccessTokenAndRefreshToken(Map<String, dynamic> tokens) {
    final prefs = SharedPreference.instance;
    String accessToken = tokens['access']!['token']!;
    String refreshToken = tokens['refresh']!['token']!;
    prefs.saveAccessToken(accessToken);
    prefs.saveRefreshToken(refreshToken);
  }

  Future<bool> signUp(String email, String password) async {
    print("signUP authentication provider");
    final result = await _authApi.register(email, password);
    if (result['user'] != null) {
      emailSave = email;
      passwordSave = password;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> logIn(String email, String password) async {
    final result = await _authApi.logIn(email, password);
    if (result['user'] != null) {
      // profile = Profile.fromMap(result["user"]);
      // backupProfile = Profile.fromMap(result["user"]);
      saveAccessTokenAndRefreshToken(result['tokens']!);
      // saveAccount(email, password);

      return true;
    }
    return false;
  }
}
