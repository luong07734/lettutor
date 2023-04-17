import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  File? avatarImage;
  // GoogleSignIn googleSignIn = GoogleSignIn();

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
      currentLoggedUser = UserProfile.fromJson(result['user']);
      tempCurrentUser = UserProfile.fromJson(result['user']);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> logIn(String email, String password) async {
    final result = await _authApi.logIn(email, password);
    if (result["message"] == "Your account has not activated") {
      return false;
    }
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

  void updateProfile(BuildContext context) {
    print("update user");
    if (avatarImage != null) {
      _userApi.updateAvatar(avatarImage!).then((outterValue) {
        _userApi.updateUserInformation(tempCurrentUser!).then((value) {
          if (value["user"] != null) {
            currentLoggedUser = UserProfile.fromJson(value["user"]);
            tempCurrentUser = UserProfile.fromJson(value["user"]);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ));

            // analyticsUpdate("update_profile", true);
          } else {
            print("not success");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Profile update failed!'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
          notifyListeners();
        });
        if (outterValue) {
          avatarImage = null;
        } else {
          // do nothing
        }
      });
    } else {
      _userApi.updateUserInformation(tempCurrentUser!).then((value) {
        if (value["user"] != null) {
          currentLoggedUser = UserProfile.fromJson(value["user"]);
          tempCurrentUser = UserProfile.fromJson(value["user"]);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Profile updated successfully!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ));
          notifyListeners();
        } else {
          print("not success");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile update failed!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    }
    print("update user xong");
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

  Future<bool> signInWithGoogle() async {
    print("google sign in");
    GoogleSignIn googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return false;

    var googleAuth = await googleUser.authentication;
    String token = googleAuth.accessToken ?? "";
    final result = await _authApi.loginByGoogle(token);
    if (result['user'] != null) {
      print(result);
      final prefs = SharedPreference.instance;
      currentLoggedUser = UserProfile.fromJson(result["user"]);
      tempCurrentUser = UserProfile.fromJson(result["user"]);
      prefs.saveCurrentLoggedUser(currentLoggedUser!);
      saveAccessTokenAndRefreshToken(result['tokens']!);
      return true;
    }
    return false;
  }

  void signOut() async {
    await GoogleSignIn().disconnect();
    // await googleSignIn.disconnect();
  }

  Future<bool> signInWithFacebook() async {
    print("fb sign in");
    var fbAuth = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);
    if (fbAuth.status != LoginStatus.success) return false;

    var accessToken = fbAuth.accessToken;
    String token = accessToken?.token ?? "";
    final result = await _authApi.loginByFacebook(token);
    if (result['user'] != null) {
      final prefs = SharedPreference.instance;
      currentLoggedUser = UserProfile.fromJson(result["user"]);
      tempCurrentUser = UserProfile.fromJson(result["user"]);
      prefs.saveCurrentLoggedUser(currentLoggedUser!);
      saveAccessTokenAndRefreshToken(result['tokens']!);
      return true;
    }
    return false;
  }
}
