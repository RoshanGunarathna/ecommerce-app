// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  //for NodeJS,MongoDB backend
  final String? password;
  final String? token;

  UserModel({
    required this.id,
    required this.email,
    //for NodeJS,MongoDB backend
    this.password,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'id': id,
      //for NodeJS,MongoDB backend
      'password': password,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      id: map['id'] ?? '',
      //for NodeJS,MongoDB backend
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }

  //for NodeJS,MongoDB backend
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  //for NodeJS,MongoDB backend
  String toJson() => json.encode(toMap());
}
