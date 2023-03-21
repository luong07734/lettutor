import 'package:flutter/material.dart';

class LanguageProfile extends ChangeNotifier {
  static const String codeVN = 'vi';
  static const String codeEN = 'en';
  // final SharedPreferenceHelper _prefHelper = SharedPreferenceHelper.instance;
  Locale locale = const Locale(codeEN);
  String get languageCode => locale.languageCode;
  LanguageProfile() {
    _loadlanguage();
  }

  _loadlanguage() async {
    print("_loadLanguage called");
    String? currentLanguage = 'en';
    if (currentLanguage == null) return;
    if (currentLanguage == codeVN) {
      locale = const Locale(codeVN);
    } else {
      locale = const Locale(codeEN);
    }
    notifyListeners();
  }

  void changeLanguage(String language) {
    if (language == codeVN) {
      locale = const Locale(codeVN);
    } else {
      locale = const Locale(codeEN);
    }
    // _prefHelper.changeLanguage(language);
    // FirebaseAnalytics.instance
    //     .logEvent(name: 'change_language', parameters: {'language': language});

    notifyListeners();
  }
}
