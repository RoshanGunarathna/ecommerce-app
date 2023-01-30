import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/common/widgets/auth_field.dart';

import '../../../core/common/widgets/gradient_button.dart';
import '../../../core/enums/enums.dart';
import '../widgets/social_button.dart';
import 'otp_verify_screen.dart';
import 'register_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Forgot Password"),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/signin_balls.png'),
                const Text(
                  'Enter your email',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 15,
                ),
                const AuthField(
                  hintText: "Email",
                  paddingVertical: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 10,
                ),
                GradientButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OTPVerifyScreen(),
                      ),
                    );
                  },
                  text: 'Send',
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Not registered yet?  ',
                    children: [
                      TextSpan(
                        text: 'Create an Account',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SocialButton(
                  horizontalPadding: 70,
                  verticalPadding: 10,
                  iconPath: "assets/svgs/g_logo.svg",
                  label: "Continue with Google",
                  socialButtonType: SocialButtonType.google,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SocialButton(
                  iconPath: "assets/svgs/f_logo.svg",
                  label: "Continue with Facebook",
                  horizontalPadding: 62,
                  verticalPadding: 10,
                  socialButtonType: SocialButtonType.facebook,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
