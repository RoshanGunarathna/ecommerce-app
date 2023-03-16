import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/firebase_constants.dart';
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
  final FacebookAuth _facebookAuth;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required FacebookAuth facebookAuth,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.userCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

//Google sign-in
  FutureEither<UserModel> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        UserModel userModel = UserModel(
          email: userCredential.user!.email ?? '',
          photoUrl: userCredential.user!.photoURL ?? Constants.avatarDefault,
          address: '',
          cart: [],
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
        );
        await _users
            .doc(userCredential.user!.uid)
            .set(UserModel.toMap(userModel: userModel));
      } else {
        final user = await getUserData(userCredential.user!.uid);
        user.fold(
          (l) => throw l.message,
          (userModel) => right(userModel),
        );
      }
      throw "null";
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //Facebook sign-in
  FutureEither<UserModel> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await _facebookAuth.login();

      // final googleAuth = await googleUser?.authentication;
      print(loginResult.status);

      final OAuthCredential credential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        UserModel userModel = UserModel(
          email: userCredential.user!.email ?? '',
          photoUrl: userCredential.user!.photoURL ?? Constants.avatarDefault,
          address: '',
          cart: [],
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
        );
        await _users.doc(userCredential.user!.uid).set(
              UserModel.toMap(userModel: userModel),
            );
      } else {
        final user = await getUserData(userCredential.user!.uid);
        user.fold(
          (l) => throw l.message,
          (userModel) => right(userModel),
        );
      }
      throw "null";
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
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
