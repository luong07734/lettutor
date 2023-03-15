import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/view/screens/log_in/log_in.dart';
import 'package:lettutor/view/screens/history/history.dart';
import 'package:lettutor/view/screens/schedule/schedule.dart';
import 'package:lettutor/view/screens/favorite_tutors/favorite_tutors.dart';
import 'package:lettutor/view/screens/tutor_register/stepper.dart';
import 'package:lettutor/view/screens/courses/course_page.dart';
import 'package:lettutor/view/screens/home/home_page.dart';
import 'package:lettutor/view/screens/tutors/tutors_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tutorial',
      home: LoginPage(),
    ),
  );
  // runApp(LessonDetail());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final List<Widget> _pages = [
    const HomePage(),
    const SchedulePage(),
    const TutorsPage(),
    CoursePage(),
    // const HistoryPage(),
    // const FavoriteTutorsPage(),
    // RegisterStepper(),
  ];
  int _currentIndex = 0;
  //GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  AssetsManager.appLogoImage,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HistoryPage(),
                    ),
                  );
                  _advancedDrawerController.hideDrawer();
                },
                leading: const Icon(Icons.schedule),
                title: const Text('Schedule History'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FavoriteTutorsPage(),
                    ),
                  );
                  _advancedDrawerController.hideDrawer();
                },
                leading: const Icon(Icons.favorite),
                title: const Text('Favourite Tutors'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterStepper(),
                    ),
                  );
                  _advancedDrawerController.hideDrawer();
                },
                leading: const Icon(Icons.co_present),
                title: const Text('Become a Tutor'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Text('Let tutor | Online tutoring system'),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            color: ColorsManager.primaryColor,
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          title: const Text(
            'Let Tutor',
            style: TextStyle(
              color: Colors.blue, // set the color of the text
              fontSize: 24, // set the font size of the text
              fontWeight: FontWeight.bold, // set the font weight of the text
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CircleAvatar(
                radius: 30,
                child: ClipOval(
                  child: Image.asset(
                    AssetsManager.avatarImage,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
        // body is the majority of the screen.
        body: Container(
          // color: Colors.blueAccent,
          child: _pages[_currentIndex],
        ),
        // floatingActionButton: const FloatingActionButton(
        //   tooltip: 'Add', // used by assistive technologies
        //   onPressed: null,
        //   child: Icon(Icons.add),
        // ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.blueAccent,
          items: const <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            // Icon(
            //   Icons.message,
            //   size: 30,
            //   color: Colors.white,
            // ),
            Icon(
              Icons.lock_clock,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.people,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.book,
              size: 30,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            //Handle button tap
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
