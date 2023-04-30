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
                  return 'Please enter your email';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
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
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password',
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
                  return 'Passwords do not match';
                }
                return null;
              },
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                hintText: 'Confirm your password',
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
                            if (value) {
                              print(value.toString());
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Dang ki thanh cong"),
                              ));
                              // Navigator.pop(context);
                              print("dang ki thanh cong");
                            } else {
                              // addError(S.current.email_is_already_in_use);
                              print("bi loi");
                              Text("email has been used");
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
