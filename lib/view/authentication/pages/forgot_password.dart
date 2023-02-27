import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/view/authentication/components/custom_button.dart';
import '../components/custom_textfield.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),

              // logo
              Image.asset(
                AssetsManager.appLogoImage,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                "Enter your email address and we'll send you\n a link to reset password",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50),

              // username textfield
              CustomTextField(
                controller: emailController,
                hintText: 'Enter your email',
                obscureText: false,
                icon: const Icon(Icons.email),
              ),

              const SizedBox(height: 50),

              // sign in button
              CustomButton(onTap: null, text: 'Send'),
            ],
          ),
        ),
      ),
    );
  }
}
