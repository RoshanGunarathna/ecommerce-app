import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:easy_linkedin_login/easy_linkedin_login.dart';
import 'package:ecommerce_app/core/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/constants/keys.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/type_defs.dart';
import '../../../model/user.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSigninProvider),
    facebookAuth: ref.read(facebookSigninProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookAuth;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required FacebookLogin facebookAuth,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.userCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

//Google sign-in
  FutureEither<UserModel?> signinWithGoogle() async {
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
            UserModel userModel = UserModel(
              email: userCredential.user!.email ?? '',
              photoUrl:
                  userCredential.user!.photoURL ?? Constants.avatarDefault,
              address: '',
              cart: [],
              id: uid,
              name: userCredential.user!.displayName ?? '',
            );
            await _users.doc(uid).set(UserModel.toMap(userModel: userModel));

            //get current user data and return userData to controller
            UserModel? user;
            final userData = await getUserData(uid);

            userData.fold(
              (l) => throw l.message,
              (userModel) => user = userModel,
            );
            return right(user);
          } else {
            //get current user data and return userData to controller
            UserModel? user;
            final userData = await getUserData(uid);

            userData.fold(
              (l) => throw l.message,
              (userModel) => user = userModel,
            );
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
  FutureEither<UserModel?> signInWithFacebook() async {
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
            UserModel userModel = UserModel(
              email: userCredential.user!.email ?? '',
              photoUrl:
                  userCredential.user!.photoURL ?? Constants.avatarDefault,
              address: '',
              cart: [],
              id: userCredential.user!.uid,
              name: userCredential.user!.displayName ?? '',
            );
            await _users.doc(userCredential.user!.uid).set(
                  UserModel.toMap(userModel: userModel),
                );

            //get current user data and return userData to controller
            UserModel? user;
            final userData = await getUserData(uid);

            userData.fold(
              (l) => throw l.message,
              (userModel) => user = userModel,
            );
            return right(user);
          } else {
            //get current user data and return userData to controller
            UserModel? user;
            final userData = await getUserData(uid);

            userData.fold(
              (l) => throw l.message,
              (userModel) => user = userModel,
            );
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

  //LinkedIn sign-in
  FutureEither<UserModel> signInWithLinkedIn(
      {required BuildContext context}) async {
    UserModel? user;
    String? error;
    BuildContext? ctx;
    bool isAuthOver = false;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LinkedInUserWidget(
          redirectUrl: linkedinRedirectURL,
          clientId: linkedinClientID,
          clientSecret: linkedinClientSecret,
          onGetUserProfile: (UserSucceededAction linkedInUser) async {
            try {
              if (linkedInUser.user.token.accessToken != null) {
                UserCredential userCredential = await _auth
                    .signInWithCustomToken(linkedInUser.user.userId!);

                if (userCredential.user != null) {
                  //get user id
                  final uid = userCredential.user!.uid;

                  if (userCredential.additionalUserInfo!.isNewUser) {
                    UserModel userModel = UserModel(
                      email: linkedInUser
                          .user.email!.elements![0].handleDeep!.emailAddress!,
                      photoUrl: linkedInUser
                              .user
                              .profilePicture!
                              .displayImageContent!
                              .elements![0]
                              .identifiers![0]
                              .identifier ??
                          Constants.avatarDefault,
                      address: '',
                      cart: [],
                      id: userCredential.user!.uid,
                      name:
                          "${linkedInUser.user.firstName!.localized!.label} ${linkedInUser.user.lastName!.localized!.label}",
                    );
                    await _users.doc(userCredential.user!.uid).set(
                          UserModel.toMap(userModel: userModel),
                        );
                    //get current user data and return userData to controller
                    final userData = await getUserData(uid);

                    //Assign values to local variable and after class will return model or error
                    userData.fold(
                      (l) => error = l.message,
                      (userModel) => user = userModel,
                    );
                    ctx = context;
                    isAuthOver = true;

                    return null;
                  } else {
                    //get current user data and return userData to controller
                    final userData = await getUserData(uid);

                    //Assign values to local variable and after class will return model or error
                    userData.fold(
                      (l) => error = l.message,
                      (userModel) => user = userModel,
                    );
                    ctx = context;
                    isAuthOver = true;

                    return null;
                  }
                }
              }
            } catch (e) {
              error = e.toString();
              ctx = context;
              isAuthOver = true;
              return null;
            }
          },
          onError: (UserFailedAction e) {
            error = e.toString();
            ctx = context;
            isAuthOver = true;
            return null;
          },
        ),
      ),
    );
    while (isAuthOver) {
      //do nothing
      print(isAuthOver);
    }
    print('****auth is over...');
    return error != null ? left(Failure(error.toString())) : right(user!);
  }

  //Email sign-Up
  FutureEither<UserModel?> signUpWithEmail(
      {required String email,
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

        //create a map for send to the firebase
        Map<String, dynamic> userMap = UserModel.toMap(
          userModel: UserModel(
            id: uid,
            name: name,
            address: "",
            email: email,
            photoUrl: "",
            cart: [],
          ),
        );

        //save data in firebase
        await _users.doc(uid).set(userMap);

        //get current user data and return userData to controller
        UserModel? user;
        final userData = await getUserData(uid);

        userData.fold(
          (l) => throw l.message,
          (userModel) => user = userModel,
        );
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
        UserModel? user;
        final userData = await getUserData(uid);

        userData.fold(
          (l) => throw l.message,
          (userModel) => user = userModel,
        );
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
  FutureEither<UserModel> getUserData(String uid) async {
    try {
      UserModel userModel = await _users.doc(uid).get().then(
          (value) => UserModel.fromMap(value.data() as Map<String, dynamic>));

      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
