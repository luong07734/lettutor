import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/view/authentication/pages/forgot_password.dart';
import 'package:lettutor/view/authentication/pages/log_in.dart';
import 'package:lettutor/view/authentication/pages/sign_up.dart';
import 'package:lettutor/view/main_feature/pages/HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tutorial',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Example title'),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Container(
        // color: Colors.blueAccent,
        child: HomePage(page: _page, bottomNavigationKey: _bottomNavigationKey),
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        onPressed: null,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.blueAccent,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.message,
            size: 30,
            color: Colors.white,
          ),
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
            Icons.settings,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
