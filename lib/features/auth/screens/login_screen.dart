import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/common/widgets/auth_field.dart';
import '../../../core/enums/enums.dart';
import '../../home/screens/home_screen.dart';

import '../../../core/common/widgets/gradient_button.dart';
import '../widgets/social_button.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/signin_balls.png'),
                const Text(
                  'Sign in.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                SizedBox(
                  height: size.height * 0.05,
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
                const Text(
                  "or",
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 15,
                ),
                const AuthField(hintText: "Email"),
                const SizedBox(
                  height: 15,
                ),
                const AuthField(hintText: "Password"),
                Row(
                  children: [
                    const SizedBox(
                      width: 225,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgotPasswordScreen()))
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GradientButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                        (route) => false);
                  },
                  text: 'Sign in',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
