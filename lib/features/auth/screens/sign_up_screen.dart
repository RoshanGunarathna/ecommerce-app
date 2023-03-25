import 'package:ecommerce_app/core/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/custom_button.dart';
import '../../../core/common/custom_icon_button.dart';
import '../../../core/common/custom_text_field.dart';
import '../../../core/constants/assets_path.dart';
import '../controller/auth_controller.dart';
import '../widgets/social_button.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void routeToSignInScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignInScreen()),
    );
  }

  void emailSignUp() {
    if (_nameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      ref.read(authControllerProvider.notifier).signUpWithEmail(
            context: context,
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
          );
    } else {}
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            //Logo
            Image.asset(logoPath, height: 220),
            const SizedBox(height: 15),
            //Name
            Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.account_circle_outlined),
                    SizedBox(width: 10),
                    Text("Your Full Name")
                  ],
                ),
                const SizedBox(height: 4),
                CustomTextField(controller: _nameController, hintText: "name")
              ],
            ),
            const SizedBox(height: 15),
            //Email
            Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.email_outlined),
                    SizedBox(width: 10),
                    Text("Your Email")
                  ],
                ),
                const SizedBox(height: 4),
                CustomTextField(controller: _emailController, hintText: "Email")
              ],
            ),
            const SizedBox(height: 15),
            //Password
            Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.lock_outline),
                    SizedBox(width: 10),
                    Text("Password")
                  ],
                ),
                const SizedBox(height: 4),
                CustomTextField(
                    controller: _passwordController, hintText: "password")
              ],
            ),
            const SizedBox(height: 25),

            //sign up button
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                text: "Sign Up",
                onPressed: emailSignUp,
              ),
            ),
            const SizedBox(height: 15),
            // or continue with F G L
            const Divider(),
            Row(
              children: const [
                Text("  Or Continue With  "),
              ],
            ),
            const SizedBox(height: 20),
            // Icon Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                SocialButton(
                    ctx: context,
                    iconPath: facebookPath,
                    label: '',
                    socialButtonType: SocialButtonType.facebook),
                SizedBox(width: 10),
                SocialButton(
                    ctx: context,
                    iconPath: googlePath,
                    label: '',
                    socialButtonType: SocialButtonType.google),
                SizedBox(width: 10),
                SocialButton(
                    ctx: context,
                    iconPath: linkedInPath,
                    label: '',
                    socialButtonType: SocialButtonType.linkedIn),
              ],
            ),
            const SizedBox(height: 15),
            // Text + text button (Already a user ? sign in)
            // Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already a user?"),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {
                      routeToSignInScreen(context);
                    },
                    child: const Text("Sign In"))
              ],
            ),
            const SizedBox(height: 5)
          ],
        ),
      ),
    ));
  }
}
