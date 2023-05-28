//enum for textField
import 'package:flutter/material.dart';

enum InputFieldType {
  email,
  password,
}

//constants
const appTitle = "Login Page";

//Hint text for text fields
const emailHintText = "your@address.net";
const passwordHintText = "**********";

//Error text for text fields
const emailErrorText = "Email is invalid";
const passwordErrorText =
    "Password should contain at least 8 characters, one numbers, one specialCharacter, one lowercase, one uppercase";

//palette
const primaryColor = Colors.black;
const secondaryColor = Colors.blue;
const whiteColor = Colors.white;

//forNodeJSMongoDBBackend
String uri = 'https://appName.cyclic.app';
