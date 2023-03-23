import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/data/provider/authentication.dart';
import 'package:lettutor/data/provider/language.dart';
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

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LanguageProfile>(create: (_) => LanguageProfile()),
      ChangeNotifierProvider<ThemeProfile>(create: (_) => ThemeProfile()),
      ChangeNotifierProvider<AuthenticationProvider>(create: (_) => AuthenticationProvider()),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    LanguageProfile languageProfile = Provider.of<LanguageProfile>(context);
    ThemeProfile themeModel = Provider.of<ThemeProfile>(context);
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
      initialRoute: Routers.LogIn,
    );
  }
}
