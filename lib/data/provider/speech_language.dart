import 'package:flutter/material.dart';
import 'package:lettutor/data/shared_preference/shared_preference.dart';

class SpeechLanguageProfile extends ChangeNotifier {
  static const String viSpeechLanguageCode = 'vi-VN';
  static const String enSpeechLanguageCode = 'en-US';
  final SharedPreference _prefHelper = SharedPreference.instance;

  String currentSpeechLanguage = enSpeechLanguageCode;
  String get speechLanguageCode => currentSpeechLanguage;

  SpeechLanguageProfile() {
    _loadlanguage();
  }

  _loadlanguage() async {
    print("_loadLanguage called");
    String? currentLanguage = await _prefHelper.currentSpeechLanguage;
    if (currentLanguage == null) {
      return;
    }

    currentSpeechLanguage = currentLanguage;
    print(currentLanguage);

    notifyListeners();
  }

  void changeLanguage(String language) {
    currentSpeechLanguage = language;

    _prefHelper.saveCurrentSpeechLanguage(language);
    // FirebaseAnalytics.instance
    //     .logEvent(name: 'change_language', parameters: {'language': language});

    notifyListeners();
  }
}
