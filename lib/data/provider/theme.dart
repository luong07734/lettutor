import 'package:flutter/material.dart';

final ThemeData themeDataLight = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  // inputDecorationTheme: inputDecorationTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // appBarTheme: appBarTheme(),
  // textTheme: textTheme(),
);

final ThemeData themeDataDark = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black87,
  // inputDecorationTheme: inputDecorationDarkTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // appBarTheme: appBarDarkTheme(),
  // textTheme: textThemeDark(),
);

class ThemeProfile extends ChangeNotifier {
  ThemeData _themeMode = themeDataLight;
  ThemeData get themeMode => _themeMode;

  String _typeName = "Light";
  String get typeName => _typeName;

  ThemeProfile() {
    _loadTheme();
  }

  _loadTheme() async {
    print("_loadTheme called");
    bool? isDark = false;
    if (isDark == true) {
      _themeMode = themeDataDark;
      _typeName = "Dark";
      // _themeModeType = ThemeMode.dark;
    } else if (isDark == false) {
      _themeMode = themeDataLight;
      _typeName = "Light";
      // _themeModeType = ThemeMode.dark;
    } else {
      _themeMode = themeDataLight;
      _typeName = "Light";
      // _themeModeType = ThemeMode.system;
    }
    notifyListeners();
  }

  void setDarkTheme() async {
    _themeMode = themeDataDark;
    _typeName = "Dark";
    // _themeModeType = ThemeMode.dark;
    // await _prefHelper?.changeBrightnessToDark(true);
    notifyListeners();
  }

  void setLightTheme() async {
    _themeMode = themeDataLight;
    _typeName = "Light";
    // _themeModeType = ThemeMode.light;
    // await _prefHelper?.changeBrightnessToDark(false);
    notifyListeners();
  }
}
