import 'package:flutter/material.dart';
import 'package:lettutor/data/network/apis/authentication/authentication_apis.dart';
import 'package:lettutor/data/network/apis/users/user_apis.dart';
import 'package:lettutor/data/shared_preference/shared_preference.dart';
import 'package:lettutor/models/user.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationApi _authApi = AuthenticationApi();
  final UserApis _userApi = UserApis();
  String? emailSave, passwordSave;
  UserProfile? currentLoggedUser;
  UserProfile? tempCurrentUser;
  final SharedPreference _prefHelper = SharedPreference.instance;

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
    tempCurrentUser = currentUserfromPref;
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
      tempCurrentUser = result['user'];
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> logIn(String email, String password) async {
    final result = await _authApi.logIn(email, password);
    if (result['user'] != null) {
      currentLoggedUser = UserProfile.fromJson(result["user"]);
      tempCurrentUser = UserProfile.fromJson(result["user"]);
      final prefs = SharedPreference.instance;
      prefs.saveCurrentLoggedUser(currentLoggedUser!);

      // backupProfile = Profile.fromMap(result["user"]);
      saveAccessTokenAndRefreshToken(result['tokens']!);
      // saveAccount(email, password);

      return true;
    }
    return false;
  }

  // void updateProfile() {
  //   if (_imageFile != null) {
  //     _userApi.updateAvatar(_imageFile!).then((value) {
  //       _userApi.updateUserInformation(backupProfile).then((value) {
  //         if (value["user"] != null) {
  //           profile = Profile.fromMap(value["user"]);
  //           backupProfile = Profile.fromMap(value["user"]);
  //           analyticsUpdate("update_profile", true);
  //         } else {
  //           analyticsUpdate("update_profile", false);
  //         }
  //         notifyListeners();
  //       });
  //       if (value) {
  //         _imageFile = null;
  //       } else {
  //         analyticsUpdate("update_avatar", false);
  //       }
  //     });
  //   } else {
  //     _userApi.updateUserInformation(backupProfile).then((value) {
  //       if (value["user"] != null) {
  //         profile = Profile.fromMap(value["user"]);
  //         backupProfile = Profile.fromMap(value["user"]);
  //       } else {}
  //       notifyListeners();
  //     });
  //   }
  // }

  void updateProfile() {
    print("update user");
    _userApi.updateUserInformation(tempCurrentUser!).then((value) {
      if (value["user"] != null) {
        currentLoggedUser = UserProfile.fromJson(value["user"]);
        tempCurrentUser = UserProfile.fromJson(value["user"]);
        notifyListeners();

        // analyticsUpdate("update_profile", true);
      } else {
        print("not success");
      }
    });
    print("update user xong");
  }

  void loadUser() {
    print("load user");
    _userApi.getUserInformation().then((value) {
      if (value["user"] != null) {
        final prefs = SharedPreference.instance;
        currentLoggedUser = UserProfile.fromJson(value["user"]);
        tempCurrentUser = UserProfile.fromJson(value["user"]);
        prefs.saveCurrentLoggedUser(currentLoggedUser!);
        print("call user ok");
        notifyListeners();
      } else {
        print("cannot get user");
      }
    });
    print("load user xong");
  }

  Future<bool> loadUser1() async {
    print("load user");
    final value = await _userApi.getUserInformation();
    if (value["user"] != null) {
      final prefs = SharedPreference.instance;
      currentLoggedUser = UserProfile.fromJson(value["user"]);
      tempCurrentUser = UserProfile.fromJson(value["user"]);
      prefs.saveCurrentLoggedUser(currentLoggedUser!);
      print("call user ok");
      notifyListeners();
      return true;
    } else {
      print("cannot get user");
      return false;
    }
  }
}
