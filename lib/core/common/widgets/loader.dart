import 'package:ecommerce_app/core/palette.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor)),
          SizedBox(
            height: 20,
          ),
          Text('We are Loading..'),
        ],
      ),
    );
  }
}
