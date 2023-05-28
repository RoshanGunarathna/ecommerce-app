import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/home/screens/home_screen.dart';

import '../../model/user_model.dart';
import '../../providers/user_provider.dart';
import '../utils/error_handling_for_NodeJs_MongoDB_backend.dart';
import '../utils/show_snack_bar.dart';
import '../../constants.dart';

class AuthService {
  //sign up the user
  void signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      UserModel user = UserModel(
        email: email,
        id: '',
        password: password,
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context: context,
                text: 'Account created! Login with the same credentials!');
          });
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  //signin user

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var encode = jsonEncode({'email': email, 'password': password});

      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: encode,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            var decode = jsonDecode(res.body);

            SharedPreferences prefs = await SharedPreferences.getInstance();

            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false)
                .setUserFromJson(res.body);
            await prefs.setString("x-auth-token", decode['token']);
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false);
            // ignore: use_build_context_synchronously
            showSnackBar(context: context, text: 'Login Complete!');
          });
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

//get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setUserFromJson(userRes.body);
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }
}
