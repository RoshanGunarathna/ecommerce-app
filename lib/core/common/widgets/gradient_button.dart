// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final String text;
  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height = 55,
    this.width = 305,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Palette.gradient1, Palette.gradient2, Palette.gradient3],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            fixedSize: Size(width, height)),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
      ),
    );
  }
}
