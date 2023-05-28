import 'package:flutter/material.dart';

import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    id: '',
    email: '',
  );

  UserModel get user => _user;

  void setUserFromModel(UserModel user) {
    _user = user;
    notifyListeners();
  }

//for NodeJS,MongoDB backend
//set user from json
  void setUserFromJson(String user) {
    _user = UserModel.fromJson(user);
    notifyListeners();
  }
}
