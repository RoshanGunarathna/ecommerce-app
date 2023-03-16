import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  final double IconSize;

  const CustomIconButton(
      {super.key,
      required this.iconPath,
      required this.onPressed,
      required this.IconSize});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(iconPath),
      iconSize: IconSize,
    );
  }
}
