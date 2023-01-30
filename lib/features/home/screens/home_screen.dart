import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Home Screen',
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Palette.whiteColor),
        ),
      ),
    );
  }
}
