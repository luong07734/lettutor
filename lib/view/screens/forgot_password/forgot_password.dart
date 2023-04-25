import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/widgets/view_items/buttons/custom_button.dart';
import 'package:lettutor/view/screens/log_in/log_in.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../widgets/view_items/textfields/custom_textfield.dart';

class ForgotPasswordPage extends StatelessWidget {
  static String routeName = "/forgot_password";
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
              Text(
                AppLocalizations.of(context)!.resetPassword,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // welcome back, you've been missed!
              Text(
                AppLocalizations.of(context)!.enterEmailAddress,
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
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routers.LogIn, (route) => false);
                  },
                  text: AppLocalizations.of(context)!.sendResetLink),
            ],
          ),
        ),
      ),
    );
  }
}
