import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/common/widgets/gradient_button.dart';
import '../../../core/common/widgets/auth_field.dart';
import '../../../core/enums/enums.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/social_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/signin_balls.png'),
                const Text(
                  'Sign Up.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                const AuthField(
                  hintText: "Email",
                  paddingVertical: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                const AuthField(
                  hintText: "Password",
                  paddingVertical: 20,
                ),
                const SizedBox(
                  height: 25,
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
                    text: "Sign up"),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account?  ',
                    children: [
                      TextSpan(
                          text: 'Login here',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            }),
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
