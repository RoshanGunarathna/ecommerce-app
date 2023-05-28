import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;
  final Color? backgroundColor;
  final Color iconColor;

  const BuildButton({
    super.key,
    required this.iconColor,
    this.backgroundColor,
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    print("back::  $backgroundColor");
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 70,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                label,
                style: TextStyle(
                    fontSize: 30,
                    color: iconColor,
                    fontWeight: FontWeight.w800),
              ),
            ],
          )),
    );
  }
}
