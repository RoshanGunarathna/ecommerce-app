// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmailUserModel {
  final String email;
  final String displayName;
  final String phoneNumber;
  final String photoUrl;
  final String uid;
  EmailUserModel({
    required this.email,
    required this.displayName,
    required this.phoneNumber,
    required this.photoUrl,
    required this.uid,
  });

  EmailUserModel copyWith({
    String? email,
    String? displayName,
    String? phoneNumber,
    String? photoUrl,
    String? uid,
  }) {
    return EmailUserModel(
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

  factory EmailUserModel.fromMap(Map<String, dynamic> map) {
    return EmailUserModel(
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailUserModel.fromJson(String source) =>
      EmailUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'emailUser(email: $email, displayName: $displayName, phoneNumber: $phoneNumber, photoUrl: $photoUrl, uid: $uid)';
  }

  @override
  bool operator ==(covariant EmailUserModel other) {
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