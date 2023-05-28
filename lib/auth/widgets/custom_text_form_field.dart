//Text input field
import 'package:flutter/material.dart';

import '../../constants.dart';

Widget customTextFormField({
  required TextEditingController controller,
  required String hintText,
  required FormFieldValidator<String?> textValidator,
  bool obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    cursorColor: primaryColor,
    style: const TextStyle(fontSize: 18),
    cursorHeight: 20,
    obscureText: obscureText,
    decoration: InputDecoration(
      fillColor: whiteColor,
      filled: true,
      hintText: hintText,
      errorMaxLines: 3,
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    ),
    validator: textValidator,
  );
}
