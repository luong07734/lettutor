import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/data/provider/authentication_provider.dart';
import 'package:lettutor/data/provider/course_provider.dart';
import 'package:lettutor/data/provider/history_provider.dart';
import 'package:lettutor/data/provider/is_auto_tts.dart';
import 'package:lettutor/data/provider/language.dart';
import 'package:lettutor/data/provider/schedule_provider.dart';
import 'package:lettutor/data/provider/speech_language.dart';
import 'package:lettutor/data/provider/tutor_provider.dart';
import 'package:lettutor/data/shared_preference/shared_preference.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/data/provider/theme.dart';
import 'package:lettutor/view/screens/components/drawer-navigation-bar.dart';
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

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey=GlobalKey<ScaffoldMessengerState>();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  final prefs = SharedPreference.instance;
  String? accessToken = await prefs.accessToken ?? "";
  String? refreshToken = await prefs.refreshToken ?? "";
  UserProfile? user = await prefs.currentLoggedUser;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LanguageProfile>(create: (_) => LanguageProfile()),
      ChangeNotifierProvider<ThemeProfile>(create: (_) => ThemeProfile()),
      ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider()),
      ChangeNotifierProvider<SpeechLanguageProfile>(
          create: (_) => SpeechLanguageProfile()),
      ChangeNotifierProvider<AutoTTSProfile>(create: (_) => AutoTTSProfile()),
    ],
    child: MyApp(token: accessToken, user: user),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({required this.token, required this.user, Key? key});
  final String? token;
  final UserProfile? user;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _accessToken;
  String? _refreshToken;

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TutorProvider>(create: (_) => TutorProvider()),
        ChangeNotifierProvider<CourseProvider>(create: (_) => CourseProvider()),
        ChangeNotifierProvider<ScheduleProvider>(
            create: (_) => ScheduleProvider()),
        ChangeNotifierProvider<HistoryProvider>(
            create: (_) => HistoryProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: 'Let Tutor',
        theme: themeModel.themeMode,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: languageProfile.locale,
        onGenerateRoute: Routers.generateRoute,
        initialRoute: (widget.token != null &&
                widget.token!.isNotEmpty &&
                widget.user != null)
            ? Routers.Home
            : Routers.LogIn,
        onGenerateInitialRoutes: (String initialRouteName) {
          return [
            MaterialPageRoute(
              builder: (context) => (widget.token != null &&
                      widget.token!.isNotEmpty &&
                      widget.user != null)
                  ? HomeDrawerAndNavigationBar()
                  : LoginPage(),
            )
          ];
        },
      ),
    );
  }
}
