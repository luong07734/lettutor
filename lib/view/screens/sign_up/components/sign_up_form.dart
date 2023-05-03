import 'package:flutter/material.dart';
import 'package:lettutor/data/provider/authentication_provider.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/screens/log_in/log_in.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool isLoading = false;
  List<String> errors = [];

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
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.pleaseEnterEmail;
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return AppLocalizations.of(context)!.emailValid;
                }
                return null;
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
              controller: _passwordController,
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
            Text(AppLocalizations.of(context)!.confirmPassword,
                style: TextStyle(fontSize: 16)),
            TextFormField(
              obscureText: !_confirmPasswordVisible,
              validator: (value) {
                if (value != _passwordController.text) {
                  return AppLocalizations.of(context)!.passwordNotMatch;
                }
                return null;
              },
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.confirmYourPassword,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
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
                          // Do something with the form data
                          final userName = _userNameController.text;
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          print('User Name: $userName');
                          print('Email: $email');
                          print('Password: $password');

                          setState(() {
                            isLoading = true;
                          });
                          authenticationProvider
                              .signUp(email, password)
                              .then((value) {
                            if (value == 1) {
                              print(value.toString());
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .signUpSuccess)),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ));
                              // Navigator.pop(context);
                              print("dang ki thanh cong");
                            } else if (value == 2) {
                              print("bi loi ton tai");
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .signUpFailedEmailTaken)),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              print("bi loi");
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .signUpFailed0)),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ));
                            }
                            setState(() {
                              isLoading = false;
                            });
                          });

                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, Routers.LogIn, (route) => false);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.signUpCapital,
                            style: const TextStyle(
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
