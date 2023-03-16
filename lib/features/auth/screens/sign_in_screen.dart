import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/custom_button.dart';
import '../../../core/common/custom_icon_button.dart';
import '../../../core/common/custom_text_field.dart';
import '../../../core/constants/assets_path.dart';
import '../../../core/palette.dart';
import '../../home/screens/home_screen.dart';
import '../controller/auth_controller.dart';
import 'sign_up_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenConsumerState();
}

class _SignInScreenConsumerState extends ConsumerState<SignInScreen> {
  bool isChecked = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void routeToHomeScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);
  }

  //call to sign-in function in the controller
  void signIn() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      ref.read(authControllerProvider.notifier).signInWithEmail(
          context: context,
          email: _emailController.text,
          password: _passwordController.text);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          //Logo
          Image.asset(logoPath, height: 260),
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
          Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              const SizedBox(width: 2),
              const Text("Remember me"),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Foget Password?",
                    style: TextStyle(color: textColor),
                  ))
            ],
          ),

          //sign up button
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomButton(
              text: "Sign In",
              onPressed: () {
                signIn();
              },
            ),
          ),
          const SizedBox(height: 15),
          // or continue with F G L
          Row(
            children: const [
              // Divider(color: Text_color),
              Text("  Or Continue With  "),
              // Divider(color: Text_color),
            ],
          ),
          const SizedBox(height: 20),
          // Icon Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconButton(
                  iconPath: facebookPath,
                  IconSize: 17,
                  onPressed: () {
                    final user = ref.read(userProvider);
                    if (user != null) {
                      print(user.name);
                    } else {
                      print('user is null');
                    }
                  }),
              const SizedBox(width: 10),
              CustomIconButton(
                  iconPath: googlePath, IconSize: 17, onPressed: () {}),
              const SizedBox(width: 10),
              CustomIconButton(
                  iconPath: linkedInPath, IconSize: 17, onPressed: () {}),
            ],
          ),
          const SizedBox(height: 15),
          // Text + text button (Already a user ? sign in)
          // const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Are You a new user?"),
              const SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SignUpScreen()));
                  },
                  child: const Text("Sign up"))
            ],
          ),
          const SizedBox(height: 5)
        ],
      ),
    ));
  }
}
