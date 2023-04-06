import 'package:ecommerce_app/core/utils.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../../home/screens/home_screen.dart';
import '../../home/widgets/bottom_bar.dart';
import '../repository/auth_repository.dart';

//loading notifier
final userProvider = StateProvider<UserModel?>((ref) => null);

//authControllerProvider
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider(
  ((ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.authStateChange;
  }),
);

//get User data
final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  //check UserStateChanges
  Stream<User?> get authStateChange => _authRepository.authStateChange;

//google sign-in
  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signinWithGoogle();
    state = false;
    user.fold((l) => showSnackBar(context: context, text: l.message),
        (userModel) {
      _ref.read(userProvider.notifier).update((state) => userModel);
      Navigator.pushNamedAndRemoveUntil(
          context, BottomBar.routeName, (route) => false);
    });
  }

//facebook sign-in
  void signInWithFacebook(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithFacebook();
    state = false;
    user.fold((l) => showSnackBar(context: context, text: l.message),
        (userModel) {
      _ref.read(userProvider.notifier).update((state) => userModel);
      Navigator.pushNamedAndRemoveUntil(
          context, BottomBar.routeName, (route) => false);
    });
  }

//** NEED TO DEVELOP **//
  //LinkedIn sign-in
  Future signInWithLinkedin({
    required UserSucceededAction linkedInUser,
    required BuildContext context,
  }) async {
    state = true;
    final user = await _authRepository.signInWithLinkedIn(
        context: context, linkedInUser: linkedInUser);
    state = false;
    user.fold((l) => showSnackBar(context: context, text: l.message),
        (userModel) {
      _ref.read(userProvider.notifier).update((state) => userModel);

      Navigator.pushNamedAndRemoveUntil(
          context, BottomBar.routeName, (route) => false);
    });
  }

//email sign-up
  void signUpWithEmail(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    state = true;
    final user = await _authRepository.signUpWithEmail(
        email: email, password: password, name: name);
    state = false;
    user.fold((l) {
      print(l.message);
      showSnackBar(context: context, text: l.message);
    }, (userModel) {
      _ref.read(userProvider.notifier).update((state) => userModel);
      Navigator.pushNamedAndRemoveUntil(
          context, BottomBar.routeName, (route) => false);
    });
  }

//email sign-in
  void signInWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final user = await _authRepository.signInWithEmail(
      email: email,
      password: password,
    );
    state = false;
    user.fold(
      (l) {
        print(l.message);
        showSnackBar(context: context, text: l.message);
      },
      (userModel) {
        _ref.read(userProvider.notifier).update((state) => userModel);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      },
    );
  }

//get current user data
  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid: uid);
  }

  //linkedIN error handling
  void linkedInErrorHandling({required String error}) {
    print("Linkedin Error: error");
  }
}
