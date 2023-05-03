import 'package:flutter/material.dart';
import 'package:lettutor/data/shared_preference/shared_preference.dart';

final ThemeData themeDataLight = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  // inputDecorationTheme: inputDecorationTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: appBarTheme(),
  // textTheme: textTheme(),
);

final ThemeData themeDataDark = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black87,
  // inputDecorationTheme: inputDecorationDarkTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: appBarDarkTheme(),
  // textTheme: textThemeDark(),
);

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: pageNameStyle,
  );
}

AppBarTheme appBarDarkTheme() {
  return const AppBarTheme(
    color: Colors.black87,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: pageNameStyle,
  );
}

const TextStyle pageNameStyle = TextStyle(
    color: Color(0xff248EEF),
    // fontSize: textSizePageName,
    fontSize: 16,
    fontWeight: FontWeight.bold);

class ThemeProfile extends ChangeNotifier {
  final SharedPreference _prefHelper = SharedPreference.instance;
  ThemeData _themeMode = themeDataLight;
  ThemeData get themeMode => _themeMode;

  String _typeName = "Light";
  String get typeName => _typeName;

  ThemeProfile() {
    _loadTheme();
  }

  _loadTheme() async {
    print("_loadTheme called");
    bool? isDark = await _prefHelper.isDark;
    print(isDark);
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
    await _prefHelper.saveIsDark(true);
    notifyListeners();
  }

  void setLightTheme() async {
    _themeMode = themeDataLight;
    _typeName = "Light";
    // _themeModeType = ThemeMode.light;
    await _prefHelper.saveIsDark(false);
    notifyListeners();
  }
}
