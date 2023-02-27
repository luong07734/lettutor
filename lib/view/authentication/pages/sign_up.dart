import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/view/authentication/components/custom_button.dart';
import '../components/custom_textfield.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  // text editing controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // username textfield
              CustomTextField(
                controller: fullNameController,
                hintText: 'Username',
                obscureText: false,
                icon: const Icon(Icons.people),
              ),

              const SizedBox(height: 10),

              // email textfield
              CustomTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                icon: const Icon(Icons.mail),
              ),

              const SizedBox(height: 10),

              // password textfield
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                icon: const Icon(Icons.password),
              ),

              const SizedBox(height: 10),

              // password textfield
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
                icon: const Icon(Icons.password),
              ),

              const SizedBox(height: 25),

              // sign in button
              const CustomButton(
                onTap: null,
                text: 'Register',
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
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

              const SizedBox(height: 50),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // IconButton(
                  //   onPressed: () {
                  //     // TODO: handle Google sign up
                  //   },
                  //   icon: Icon(
                  //     FontAwesome.google,
                  //     color: Colors.red,
                  //   ),
                  // ),
                  const SizedBox(width: 25),
                  IconButton(
                    onPressed: () {
                      // TODO: handle Facebook sign up
                    },
                    icon: const Icon(Icons.facebook),
                  ),

                  // apple button
                  // SquareTile(imagePath: 'lib/images/apple.png')
                ],
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
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
