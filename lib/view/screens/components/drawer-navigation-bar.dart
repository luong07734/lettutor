import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/data/provider/authentication_provider.dart';
import 'package:lettutor/data/shared_preference/shared_preference.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:lettutor/view/screens/courses/course_page.dart';
import 'package:lettutor/view/screens/home/home_page.dart';
import 'package:lettutor/view/screens/schedule/schedule.dart';
import 'package:lettutor/view/screens/tutors/tutors_page.dart';
import 'package:provider/provider.dart';
import 'package:lettutor/models/user.dart';

class HomeDrawerAndNavigationBar extends StatefulWidget {
  const HomeDrawerAndNavigationBar({super.key});

  @override
  State<HomeDrawerAndNavigationBar> createState() =>
      _HomeDrawerAndNavigationBarState();
}

class _HomeDrawerAndNavigationBarState
    extends State<HomeDrawerAndNavigationBar> {
  // This widget is the root of your application.
  List<Widget> _pages = [];
  int _currentIndex = 0;
  //GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();
  final GlobalKey<CurvedNavigationBarState> _navBarKey = GlobalKey();

  void handleSelection(int index) {
    setState(() {
      _currentIndex = index;
      _navBarKey.currentState?.setPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(moveAtIndex: handleSelection),
      const SchedulePage(),
      const TutorsPage(),
      CoursePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authProvider =
        Provider.of<AuthenticationProvider>(context);
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
                  Navigator.pushNamed(context, Routers.History);
                  _advancedDrawerController.hideDrawer();
                },
                leading: const Icon(Icons.schedule),
                title: Text(AppLocalizations.of(context)!.scheduleHistory),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routers.Favorite);
                  _advancedDrawerController.hideDrawer();
                },
                leading: const Icon(Icons.favorite),
                title: Text(AppLocalizations.of(context)!.favoriteTutors),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routers.BecomeTutor);
                  _advancedDrawerController.hideDrawer();
                },
                leading: const Icon(Icons.co_present),
                // title: const Text('Become a Tutor'),
                title: Text(AppLocalizations.of(context)!.becomeATutor),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routers.Chat);
                  _advancedDrawerController.hideDrawer();
                },
                leading: const Icon(Icons.chat),
                title: Text("VoiceGPT"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routers.Settings);
                  _advancedDrawerController.hideDrawer();
                },
                leading: const Icon(Icons.settings),
                title: Text(AppLocalizations.of(context)!.settings),
              ),
              ListTile(
                onTap: () {
                  final prefs = SharedPreference.instance;
                  prefs.removeAccessToken();
                  prefs.removeRefreshToken();
                  prefs.removeCurrentLoggedUser();
                  authProvider.signOut();

                  Navigator.pushNamedAndRemoveUntil(
                      context, Routers.LogIn, (route) => false);
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(builder: (context) => LoginPage()),
                  //     (Route<dynamic> route) => false);
                },
                leading: const Icon(Icons.logout),
                title: Text(AppLocalizations.of(context)!.logout),
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
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routers.Profile);
                },
                child: CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: authProvider.currentLoggedUser == null ||
                            authProvider.currentLoggedUser!.avatar!
                                .contains("icon-avatar-default.png")
                        ? Image.asset(AssetsManager.userAvatarImage)
                        : Image.network(
                            authProvider.currentLoggedUser!.avatar!,
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          ),
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
          key: _navBarKey,
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
