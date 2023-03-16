// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

class CustomTabButton extends StatefulWidget {
  final String text;
  const CustomTabButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomTabButton> createState() => _CustomTabButtonState();
}

class _CustomTabButtonState extends State<CustomTabButton> {
  bool _isSelected = false;

  void changeButtonColor() {
    if (_isSelected == true) {
      _isSelected = false;
    } else {
      _isSelected = true;
    }
    setState(() {
      _isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeButtonColor();
      },
      child: Container(
        // width: 82,
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isSelected ? Colors.black : Colors.white,
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
              color: _isSelected ? Colors.green : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
