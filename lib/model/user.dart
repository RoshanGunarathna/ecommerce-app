// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String name;

  final String address;
  final String email;
  final String photoUrl;
  final List<dynamic> cart;
  UserModel({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.photoUrl,
    required this.cart,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? password,
    String? address,
    String? email,
    String? photoUrl,
    List<dynamic>? cart,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      address: address ?? this.address,
      cart: cart ?? this.cart,
    );
  }

  static Map<String, dynamic> toMap({
    required UserModel userModel,
  }) {
    return <String, dynamic>{
      'email': userModel.email,
      'name': userModel.name,
      'id': userModel.id,
      'photoUrl': userModel.photoUrl,
      'address': userModel.address,
      'cart': userModel.cart,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      address: map['address'] ?? '',
      cart: map['cart'] ?? [],
    );
  }

  // @override
  // String toString() {
  //   return 'emailUser(email: $email, displayName: $displayName, phoneNumber: $phoneNumber, photoUrl: $photoUrl, uid: $uid)';
  // }

  // @override
  // bool operator ==(covariant UserModel other) {
  //   if (identical(this, other)) return true;

  //   return other.email == email &&
  //       other.displayName == displayName &&
  //       other.phoneNumber == phoneNumber &&
  //       other.photoUrl == photoUrl &&
  //       other.uid == uid;
  // }

  // @override
  // int get hashCode {
  //   return email.hashCode ^
  //       displayName.hashCode ^
  //       phoneNumber.hashCode ^
  //       photoUrl.hashCode ^
  //       uid.hashCode;
  // }
}





    // print(userCredential.user!.email);
    //   print(userCredential.user!.displayName);
    //   print(userCredential.user!.phoneNumber);
    //   print(userCredential.user!.photoURL);
    //   print(userCredential.user!.uid);