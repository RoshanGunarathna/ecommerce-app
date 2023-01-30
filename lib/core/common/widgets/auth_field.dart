// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final double paddingVertical;
  final double paddingHorizontal;
  final double maxWidthField;
  const AuthField({
    Key? key,
    this.paddingVertical = 10,
    this.paddingHorizontal = 10,
    this.maxWidthField = 310,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidthField,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: paddingVertical, horizontal: paddingHorizontal),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.borderColor, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.gradient2, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
