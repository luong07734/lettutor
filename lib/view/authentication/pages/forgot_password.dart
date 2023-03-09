import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/view/authentication/components/custom_button.dart';
import 'package:lettutor/view/authentication/pages/log_in.dart';
import '../components/custom_textfield.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // logo
              const SizedBox(height: 24),
              Image.asset(
                AssetsManager.loginImage,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 36),
              const Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // welcome back, you've been missed!
              Text(
                "Enter your email address and we'll send you\n a link to reset password",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // username textfield
              CustomTextField(
                controller: emailController,
                hintText: 'Enter your email',
                obscureText: false,
                icon: const Icon(Icons.email),
              ),

              const SizedBox(height: 24),

              // sign in button
              CustomButton(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  text: 'Send'),
            ],
          ),
        ),
      ),
    );
  }
}
