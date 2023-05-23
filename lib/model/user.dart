// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_app/model/product.dart';

import 'address_model.dart';

class UserModel {
  final String id;
  final String name;

  final List<AddressModel> address;
  final String email;
  final String photoUrl;
  final List<ProductModel> cart;
  final DateTime? dateTime;
  final List<ProductModel> favorite;
  UserModel({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.photoUrl,
    required this.cart,
    this.dateTime,
    required this.favorite,
  });

  UserModel copyWith({
    String? id,
    String? name,
    List<AddressModel>? address,
    String? email,
    String? photoUrl,
    List<ProductModel>? cart,
    DateTime? dateTime,
    List<ProductModel>? favorite,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      cart: cart ?? this.cart,
      dateTime: dateTime ?? this.dateTime,
      favorite: favorite ?? this.favorite,
    );
  }

  static Map<String, dynamic> toMap({
    required UserModel userModel,
    required List<String> searchKeyword,
  }) {
    return <String, dynamic>{
      'email': userModel.email,
      'name': userModel.name,
      'id': userModel.id,
      'photoUrl': userModel.photoUrl,
      'address': userModel.address.map((address) => address.toMap()).toList(),
      'cart': userModel.cart.map((product) {
        //Generate search Keywords
        final List<String> searchKeyword = [];
        final splittedMultipleWords = product.name.trim().split(" ");
        for (var element in splittedMultipleWords) {
          final String wordToLowercase = element.toLowerCase();
          for (var i = 1; i < wordToLowercase.length + 1; i++) {
            searchKeyword.add(wordToLowercase.substring(0, i));
          }
        }

        return ProductModel.toMap(
            productModel: product, searchKeyword: searchKeyword);
      }).toList(),
      'searchKeyword': searchKeyword,
      'dateTime': userModel.dateTime.toString(),
      'favorite': userModel.favorite.isNotEmpty
          ? userModel.favorite.map((product) {
              //Generate search Keywords
              final List<String> searchKeyword = [];
              final splittedMultipleWords = product.name.trim().split(" ");
              for (var element in splittedMultipleWords) {
                final String wordToLowercase = element.toLowerCase();
                for (var i = 1; i < wordToLowercase.length + 1; i++) {
                  searchKeyword.add(wordToLowercase.substring(0, i));
                }
              }

              return ProductModel.toMap(
                  productModel: product, searchKeyword: searchKeyword);
            }).toList()
          : [],
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      address: (map['address']).isNotEmpty
          ? List<AddressModel>.from(
              map['address'].map(
                (address) => AddressModel.fromMap(address),
              ),
            )
          : [],
      cart: List<ProductModel>.from(
        map['cart']?.map((res) {
          final product = ProductModel.fromMap(res);

          return product;
        }),
      ).toList(),
      dateTime:
          map['dateTime'] != null ? DateTime.parse(map['dateTime']) : null,
      favorite: (map['favorite'] as List).isNotEmpty
          ? List<ProductModel>.from(map['favorite']?.map((res) {
              final product = ProductModel.fromMap(res);

              return product;
            }))
          : [],
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