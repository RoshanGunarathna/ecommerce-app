import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/auth/utils/show_snack_bar.dart';

import '../../model/user_model.dart';
import '../../providers/user_provider.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _users =>
      _firestore.collection('flutterIgenagamuUsers');

  //Email sign-Up
  Future<bool> signUpWithEmail({
    required String email,
    required BuildContext context,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //get user id
      final uid = userCredential.user!.uid;

      final userModel = UserModel(
        id: uid,
        email: email,
      );

      //create a map for send to the firebase
      Map<String, dynamic> userMap = userModel.toMap();

      //save data in firebase
      await _users.doc(uid).set(userMap);

      return true;
    } on FirebaseException catch (e) {
      showSnackBar(context: context, text: e.message.toString());
      return false;
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
      return false;
    }
  }

  //Email sign-In
  Future<bool> signInWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //get user id
      final uid = userCredential.user!.uid;

      //get current user data
      // ignore: use_build_context_synchronously
      final user = await getUserData(uid: uid, context: context);

      if (user != null) {
        var userProvider =
            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false);

        userProvider.setUserFromModel(user);

        return true;
      }
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, text: "get User Fail");
      return false;
    } on FirebaseException catch (e) {
      showSnackBar(context: context, text: e.message.toString());
      return false;
    } catch (e) {
      print(e.toString());
      showSnackBar(context: context, text: e.toString());
      return false;
    }
  }

  //get user data
  Future<UserModel?> getUserData(
      {required String uid, required BuildContext context}) async {
    try {
      final user = await _users.doc(uid).get().then(
          (value) => UserModel.fromMap(value.data() as Map<String, dynamic>));
      return user;
    } on FirebaseException catch (e) {
      showSnackBar(context: context, text: e.message.toString());
      return null;
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
      return null;
    }
  }

  //logOut
  Future<bool> signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      return true;
    } on FirebaseException catch (e) {
      showSnackBar(context: context, text: e.message.toString());
      return false;
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
      return false;
    }
  }
}
