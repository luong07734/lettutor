import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/data/provider/authentication_provider.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/screens/sign_up/components/sign_up_form.dart';
import 'package:lettutor/view/screens/log_in/log_in.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  static String routeName = "/sign_up";
  SignUpPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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

                ProfileTitle(text: AppLocalizations.of(context)!.startLearning),
                // welcome back, you've been missed!
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    AppLocalizations.of(context)!.becomeFluent,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),

                SignupForm(),
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
                          AppLocalizations.of(context)!.orContinueWith,
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
                        authProvider.signInWithGoogle().then((value) {
                          if (value) {
                            Navigator.pushReplacementNamed(
                              context,
                              Routers.Home,
                            );
                            // initData();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Login failed",
                                toastLength: Toast.LENGTH_LONG,
                                timeInSecForIosWeb: 2);
                          }
                        });
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
                      AppLocalizations.of(context)!.alreadyAccount,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: (() {
                        Navigator.pushNamed(context, Routers.LogIn);
                      }),
                      child: Text(
                        AppLocalizations.of(context)!.logIn,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
