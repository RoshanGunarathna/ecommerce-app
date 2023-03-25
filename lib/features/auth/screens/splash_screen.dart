import 'package:flutter/material.dart';

import '../../../core/constants/assets_path.dart';

import 'sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//In this state we will initialize the auth part
  Future<void> appStartInit() async {
    Future.delayed(
      const Duration(seconds: 3),
    ).then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    appStartInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(logoPath),
        ),
      ),
    );
  }
}
