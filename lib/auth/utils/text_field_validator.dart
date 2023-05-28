//Text input field validation
import '../../constants.dart';

String? textValidator({
  required String? typedText,
  required InputFieldType inputFieldType,
}) {
  String? returnValue;

  //common validation
  if (typedText != null && typedText.isEmpty) {
    return "Field cannot be empty";
  }

  //email validation
  if (inputFieldType == InputFieldType.email) {
    final bool emailValidation = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(typedText!);
    if (emailValidation == false) {
      returnValue = emailErrorText;
    }
  }

  //password validation
  if (inputFieldType == InputFieldType.password) {
    final bool passwordValidation =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(typedText!);
    if (passwordValidation == false) {
      returnValue = passwordErrorText;
    }
  }

  return returnValue;
}
