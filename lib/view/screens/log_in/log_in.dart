import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/screens/log_in/components/log_in_form.dart';
import 'package:lettutor/view/screens/sign_up/sign_up.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/log_in";
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Image.asset(
                AssetsManager.loginImage,
                width: 200,
                height: 200,
              ),

              const SizedBox(height: 12),

              ProfileTitle(text: "Say hello to your English tutors"),
              // welcome back, you've been missed!
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Become fluent faster through one on one video chat lessons tailored to your goals.',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              SigninForm(),
              const SizedBox(height: 24.0),
              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO: handle Facebook sign up
                    },
                    icon: const Icon(FontAwesomeIcons.facebook, size: 25.0),
                  ),
                  const SizedBox(width: 25),
                  IconButton(
                    onPressed: () {
                      // TODO: handle Facebook sign up
                    },
                    icon: const Icon(FontAwesomeIcons.google, size: 25.0),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member yet?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: (() {
                      Navigator.pushNamed(context, Routers.SignUp);
                    }),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
