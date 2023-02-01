// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String displayName;
  final String phoneNumber;
  final String photoUrl;
  final String uid;
  UserModel({
    required this.email,
    required this.displayName,
    required this.phoneNumber,
    required this.photoUrl,
    required this.uid,
  });

  UserModel copyWith({
    String? email,
    String? displayName,
    String? phoneNumber,
    String? photoUrl,
    String? uid,
  }) {
    return UserModel(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  @override
  String toString() {
    return 'emailUser(email: $email, displayName: $displayName, phoneNumber: $phoneNumber, photoUrl: $photoUrl, uid: $uid)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.displayName == displayName &&
        other.phoneNumber == phoneNumber &&
        other.photoUrl == photoUrl &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        displayName.hashCode ^
        phoneNumber.hashCode ^
        photoUrl.hashCode ^
        uid.hashCode;
  }
}





    // print(userCredential.user!.email);
    //   print(userCredential.user!.displayName);
    //   print(userCredential.user!.phoneNumber);
    //   print(userCredential.user!.photoURL);
    //   print(userCredential.user!.uid);