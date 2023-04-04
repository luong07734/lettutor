import 'package:flutter/material.dart';
import 'package:lettutor/data/network/apis/authentication/authentication_apis.dart';
import 'package:lettutor/data/shared_preference/shared_preference.dart';
import 'package:lettutor/models/user.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationApi _authApi = AuthenticationApi();
  String? emailSave, passwordSave;
  UserProfile? currentLoggedUser;
  final SharedPreference _prefHelper = SharedPreference.instance;

  // AuthenticationProvider() {
  //   loadUser();
  // }

 AuthenticationProvider() {
    _loadUser();
  }

  _loadUser() async {
    print("_loadUser called");
    UserProfile? currentUserfromPref = await _prefHelper.currentLoggedUser;
    if (currentUserfromPref == null) {
      return;
    }

    currentLoggedUser = currentUserfromPref;
    print(currentUserfromPref);

    notifyListeners();
  }


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
      currentLoggedUser = result['user'];
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> logIn(String email, String password) async {
    final result = await _authApi.logIn(email, password);
    if (result['user'] != null) {
      currentLoggedUser = UserProfile.fromJson(result["user"]);
      final prefs = SharedPreference.instance;
      prefs.saveCurrentLoggedUser(currentLoggedUser!);

      // backupProfile = Profile.fromMap(result["user"]);
      saveAccessTokenAndRefreshToken(result['tokens']!);
      // saveAccount(email, password);

      return true;
    }
    return false;
  }
}
