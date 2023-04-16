import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_app/core/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../../../core/common/controller/common_get_date_and_time_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/constants/keys.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/type_defs.dart';
import '../../../model/user.dart';
import '../screens/sign_up_screen.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.watch(firestoreProvider),
    auth: ref.watch(authProvider),
    googleSignIn: ref.watch(googleSigninProvider),
    facebookAuth: ref.watch(facebookSigninProvider),
    ref: ref,
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookAuth;
  final Ref _ref;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required FacebookLogin facebookAuth,
    required Ref ref,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth,
        _ref = ref;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.userCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

//Google sign-in
  FutureEither<UserModel?> signinWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          //get user id
          final uid = userCredential.user!.uid;

          if (userCredential.additionalUserInfo!.isNewUser) {
            //get the time&date in sri lanka
            String? dateAndTime = await _ref
                .read(commonGetDateAndTimeControllerProvider.notifier)
                .getDateAndTime(context);

            UserModel userModel = UserModel(
              email: userCredential.user!.email ?? '',
              photoUrl:
                  userCredential.user!.photoURL ?? Constants.avatarDefault,
              address: '',
              cart: [],
              id: uid,
              name: userCredential.user!.displayName ?? '',
              dateTime: dateAndTime != null
                  ? DateTime.parse(dateAndTime)
                  : DateTime.now(),
            );

            //Generate search Keywords
            final List<String> searchKeyword = [];
            final splittedMultipleWords = userModel.name.trim().split(" ");
            for (var element in splittedMultipleWords) {
              final String wordToLowercase = element.toLowerCase();
              for (var i = 1; i < wordToLowercase.length + 1; i++) {
                searchKeyword.add(wordToLowercase.substring(0, i));
              }
            }

            await _users.doc(uid).set(UserModel.toMap(
                userModel: userModel, searchKeyword: searchKeyword));

            //get current user data and return userData to controller
            final user = await getUserData(
              uid: uid,
            ).first;
            return right(user);
          } else {
            //get current user data and return userData to controller
            final user = await getUserData(
              uid: uid,
            ).first;
            return right(user);
          }
          ;
        }
      }

      throw "Google sign-in fail";
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //Facebook sign-in
  FutureEither<UserModel?> signInWithFacebook(BuildContext context) async {
    try {
      final FacebookLoginResult loginResult =
          await _facebookAuth.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      if (loginResult.status == FacebookLoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          //get user id
          final uid = userCredential.user!.uid;
          if (userCredential.additionalUserInfo!.isNewUser) {
            //get the time&date in sri lanka
            String? dateAndTime = await _ref
                .read(commonGetDateAndTimeControllerProvider.notifier)
                .getDateAndTime(context);

            UserModel userModel = UserModel(
              email: userCredential.user!.email ?? '',
              photoUrl:
                  userCredential.user!.photoURL ?? Constants.avatarDefault,
              address: '',
              cart: [],
              id: userCredential.user!.uid,
              name: userCredential.user!.displayName ?? '',
              dateTime: dateAndTime != null
                  ? DateTime.parse(dateAndTime)
                  : DateTime.now(),
            );

            //Generate search Keywords
            final List<String> searchKeyword = [];
            final splittedMultipleWords = userModel.name.trim().split(" ");
            for (var element in splittedMultipleWords) {
              final String wordToLowercase = element.toLowerCase();
              for (var i = 1; i < wordToLowercase.length + 1; i++) {
                searchKeyword.add(wordToLowercase.substring(0, i));
              }
            }

            await _users.doc(userCredential.user!.uid).set(
                  UserModel.toMap(
                      userModel: userModel, searchKeyword: searchKeyword),
                );

            //get current user data and return userData to controller
            final user = await getUserData(
              uid: uid,
            ).first;
            return right(user);
          } else {
            //get current user data and return userData to controller
            final user = await getUserData(
              uid: uid,
            ).first;
            return right(user);
          }
        }
      }

      throw "${loginResult.status}";
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

//** NEED TO DEVELOP **//
  //LinkedIn sign-in
  FutureEither<UserModel?> signInWithLinkedIn(
      {required BuildContext context,
      required UserSucceededAction linkedInUser}) async {
    try {
      if (linkedInUser.user.token.accessToken != null) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: linkedInUser
                    .user.email!.elements![0].handleDeep!.emailAddress!,
                password: linkedInUser.user.userId!);

        if (userCredential.user != null) {
          //get user id
          final uid = userCredential.user!.uid;

          //get the time&date in sri lanka
          String? dateAndTime = await _ref
              .read(commonGetDateAndTimeControllerProvider.notifier)
              .getDateAndTime(context);

          //Generate search Keywords
          final List<String> searchKeyword = [];
          final splittedMultipleWords =
              "${linkedInUser.user.firstName!.localized!.label} ${linkedInUser.user.lastName!.localized!.label}"
                  .trim()
                  .split(" ");
          for (var element in splittedMultipleWords) {
            final String wordToLowercase = element.toLowerCase();
            for (var i = 1; i < wordToLowercase.length + 1; i++) {
              searchKeyword.add(wordToLowercase.substring(0, i));
            }
          }

          //create a map for send to the firebase
          Map<String, dynamic> userMap = UserModel.toMap(
              searchKeyword: searchKeyword,
              userModel: UserModel(
                email: linkedInUser
                    .user.email!.elements![0].handleDeep!.emailAddress!,
                photoUrl: linkedInUser.user.profilePicture != null
                    ? linkedInUser.user.profilePicture!.displayImageContent!
                        .elements![0].identifiers![0].identifier
                        .toString()
                    : Constants.avatarDefault,
                address: '',
                cart: [],
                id: uid,
                name:
                    "${linkedInUser.user.firstName!.localized!.label} ${linkedInUser.user.lastName!.localized!.label}",
                dateTime: dateAndTime != null
                    ? DateTime.parse(dateAndTime)
                    : DateTime.now(),
              ));

          //save data in firebase
          await _users.doc(uid).set(userMap);

          //get current user data and return userData to controller
          final user = await getUserData(
            uid: uid,
          ).first;
          return right(user);
        } else {
          throw "user is Null";
        }
      }

      throw "user is Null";
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //Email sign-Up
  FutureEither<UserModel?> signUpWithEmail(
      {required String email,
      required BuildContext context,
      required String password,
      required String name}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        //get user id
        final uid = userCredential.user!.uid;

        // get the time&date in sri lanka
        String? dateAndTime = await _ref
            .read(commonGetDateAndTimeControllerProvider.notifier)
            .getDateAndTime(context);

        //Generate search Keywords
        final List<String> searchKeyword = [];
        final splittedMultipleWords = name.trim().split(" ");
        for (var element in splittedMultipleWords) {
          final String wordToLowercase = element.toLowerCase();
          for (var i = 1; i < wordToLowercase.length + 1; i++) {
            searchKeyword.add(wordToLowercase.substring(0, i));
          }
        }

        //create a map for send to the firebase
        Map<String, dynamic> userMap = UserModel.toMap(
          searchKeyword: searchKeyword,
          userModel: UserModel(
            id: uid,
            name: name,
            address: "",
            email: email,
            photoUrl: "",
            cart: [],
            dateTime: dateAndTime != null
                ? DateTime.parse(dateAndTime)
                : DateTime.now(),
          ),
        );

        //save data in firebase
        await _users.doc(uid).set(userMap);
        //get current user data and return userData to controller
        final user = await getUserData(
          uid: uid,
        ).first;
        return right(user);
      }

      throw 'null';
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //Email sign-In
  FutureEither<UserModel?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        //get user id
        final uid = userCredential.user!.uid;

        //get current user data and return userData to controller
        final user = await getUserData(uid: uid).first;
        return right(user);
      }

      throw 'user is null';
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //get user data
  Stream<UserModel> getUserData({required String uid}) {
    return _users.doc(uid).snapshots().map((event) {
      return UserModel.fromMap(event.data() as Map<String, dynamic>);
    });
  }
}
