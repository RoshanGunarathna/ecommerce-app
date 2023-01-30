import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../core/common/widgets/auth_field.dart';

import '../../../core/common/widgets/gradient_button.dart';
import 'new_password_screen.dart';
import 'register_screen.dart';

class OTPVerifyScreen extends StatelessWidget {
  const OTPVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Verification"),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/signin_balls.png'),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Text(
                  'Enter Verification code',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Pinput(),
                const SizedBox(
                  height: 25,
                ),
                GradientButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NewPasswordScreen(),
                      ),
                    );
                  },
                  text: 'Verify',
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    text: 'If you didn\'t receive a code!  ',
                    children: [
                      TextSpan(
                        text: 'Resend',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
