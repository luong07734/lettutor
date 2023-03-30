import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/data/provider/authentication.dart';
import 'package:lettutor/data/provider/language.dart';
import 'package:lettutor/data/shared_preference/shared_preference.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/data/provider/theme.dart';
import 'package:lettutor/view/screens/log_in/log_in.dart';
import 'package:lettutor/view/screens/history/history.dart';
import 'package:lettutor/view/screens/schedule/schedule.dart';
import 'package:lettutor/view/screens/favorite_tutors/favorite_tutors.dart';
import 'package:lettutor/view/screens/tutor_register/stepper.dart';
import 'package:lettutor/view/screens/courses/course_page.dart';
import 'package:lettutor/view/screens/home/home_page.dart';
import 'package:lettutor/view/screens/tutors/tutors_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LanguageProfile>(create: (_) => LanguageProfile()),
      ChangeNotifierProvider<ThemeProfile>(create: (_) => ThemeProfile()),
      ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider()),
    ],
    child: const MyApp(),
  ));
  // runApp(LessonDetail());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _accessToken;
  String? _refreshToken;

  Future<bool> _checkTokenValidity() async {
    final prefs = SharedPreference.instance;
    String? accessToken = await prefs.accessToken;
    String? refreshToken = await prefs.refreshToken;
    DateTime now = DateTime.now();
    if (accessToken != null) {
      // Check if access token has expired
      // Map<String, dynamic> decodedAccessToken = json.decode(accessToken);
      // String expiryTimeString = decodedAccessToken['expiry_time'];
      // DateTime expiryTime =
      //     DateFormat("yyyy-MM-dd HH:mm:ss").parse(expiryTimeString);
      // if (expiryTime.isBefore(now)) {
      //   // Access token has expired, try to refresh it using the refresh token
      //   if (refreshToken != null) {
      //     // Perform refresh token logic here
      //     // If successful, update access token in shared preferences
      //     // If not successful, prompt user to sign in again
      //   } else {
      //     // No refresh token available, prompt user to sign in again
      //     isSignIn = false;
      //     print("signin page");
      //   }
      // } else {
      //   // Access token is still valid, redirect user to home page
      //   print("home page");
      //   isSignIn = true;
      // }
      print("home page");
      return true;
    } else {
      // No access token available, redirect user to sign in page
       print("sign in page");
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    // _checkTokenValidity();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    LanguageProfile languageProfile = Provider.of<LanguageProfile>(context);
    ThemeProfile themeModel = Provider.of<ThemeProfile>(context);
    return FutureBuilder(
      future: _checkTokenValidity(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return MaterialApp(
        //     debugShowCheckedModeBanner: false,
        //     home: Scaffold(
        //       body: Center(
        //         child: CircularProgressIndicator(),
        //       ),
        //     ),
        //   );
        // } else 
        if (snapshot.data == true) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Let Tutor',
            // home: LoginPage(),
            // routes: routes,
            theme: themeModel.themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: languageProfile.locale,
            onGenerateRoute: Routers.generateRoute,
            initialRoute: Routers.Home,
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Let Tutor',
            theme: themeModel.themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: languageProfile.locale,
            onGenerateRoute: Routers.generateRoute,
            initialRoute: Routers.LogIn,
          );
        }
      },
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Let Tutor',
    //   // home: LoginPage(),
    //   // routes: routes,
    //   theme: themeModel.themeMode,
    //   localizationsDelegates: AppLocalizations.localizationsDelegates,
    //   supportedLocales: AppLocalizations.supportedLocales,
    //   locale: languageProfile.locale,
    //   onGenerateRoute: Routers.generateRoute,
    //   initialRoute: isSignIn ? Routers.Home : Routers.LogIn,
    // );
  }
}
