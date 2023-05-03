import 'package:flutter/material.dart';
import 'package:lettutor/data/provider/authentication_provider.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/screens/components/drawer-navigation-bar.dart';
import 'package:lettutor/view/screens/forgot_password/forgot_password.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

class SigninForm extends StatefulWidget {
  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _passwordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authenticationProvider =
        context.read<AuthenticationProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.email,
                style: TextStyle(fontSize: 16)),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.pleaseEnterEmail;
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return AppLocalizations.of(context)!.emailValid;
                }
                return null;
              },
              onChanged: (value) {
                _email = value;
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterEmail,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.password,
                style: TextStyle(fontSize: 16)),
            TextFormField(
              obscureText: !_passwordVisible,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.pleaseEnterPassword;
                } else if (value.length < 6) {
                  return AppLocalizations.of(context)!.passwordLength;
                }
                return null;
              },
              onChanged: (value) {
                _password = value;
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterPassword,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routers.ForgotPassword);
              },
              child: Text(
                AppLocalizations.of(context)!.forgotPassword,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: isLoading
                  ? CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation(Colors.blue),
                      backgroundColor: Colors.grey[200],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Do sign in here

                          setState(() {
                            isLoading = true;
                          });
                          authenticationProvider
                              .logIn(_email!, _password!)
                              .then((value) {
                            if (value == 1) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeDrawerAndNavigationBar()),
                                  (Route<dynamic> route) => false);
                            } else if (value == 2) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .loginFailedNotActivated)),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ));
                            } else if (value == 3) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .loginFailedNotWrong)),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .loginFailed0)),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ));
                            }
                            setState(() {
                              isLoading = false;
                            });
                          });
                          print('Email: $_email');
                          print('Password: $_password');

                          //TO DO: change to named navigator
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.signIn,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
