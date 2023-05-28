import 'package:ecommerce_app/core/utils.dart';
import 'package:ecommerce_app/features/home/widgets/bottom_bar.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../repository/auth_repository.dart';
import '../screens/get_email_screen.dart';
import '../screens/sign_in_screen.dart';

//user provider
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
    final user = await _authRepository.signInWithGoogle(context);
    state = false;
    user.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (userModel) async {
      if (userModel != null) {
        if (userModel.email.isNotEmpty) {
          print("**EmailIsIncluded");
          await _ref.read(userProvider.notifier).update((state) => userModel);
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        } else {
          print("**NoEmail");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GetEmailScreen(
                uid: userModel.id,
              ),
            ),
          );
        }
      } else {
        await _ref.read(userProvider.notifier).update((state) => null);
      }
    });
  }

//facebook sign-in
  void signInWithFacebook(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithFacebook(context);
    state = false;
    user.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (userModel) async {
      if (userModel != null) {
        if (userModel.email.isNotEmpty) {
          print("**EmailIsIncluded");
          await _ref.read(userProvider.notifier).update((state) => userModel);
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        } else {
          print("**NoEmail");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GetEmailScreen(
                uid: userModel.id,
              ),
            ),
          );
        }
      } else {
        await _ref.read(userProvider.notifier).update((state) => null);
      }
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
        (userModel) async {
      if (userModel != null) {
        if (userModel.email.isNotEmpty) {
          print("**EmailIsIncluded");
          await _ref.read(userProvider.notifier).update((state) => userModel);
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        } else {
          print("**NoEmail");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GetEmailScreen(
                uid: userModel.id,
              ),
            ),
          );
        }
      } else {
        await _ref.read(userProvider.notifier).update((state) => null);
      }
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
        context: context, email: email, password: password, name: name);
    state = false;
    user.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (isOk) {
      if (isOk) {
        showSnackBar(
            context: context, text: "Register completed! Now you can Sign-IN");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SignInScreen(
              emailControllerText: email,
            ),
          ),
        );
      }
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
        showSnackBar(context: context, text: l.message);
      },
      (userModel) async {
        if (userModel != null) {
          if (userModel.email.isNotEmpty) {
            print("**EmailIsIncluded");
            await _ref.read(userProvider.notifier).update((state) => userModel);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          } else {
            print("**NoEmail");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GetEmailScreen(
                  uid: userModel.id,
                ),
              ),
            );
          }
        } else {
          await _ref.read(userProvider.notifier).update((state) => null);
        }
      },
    );
  }

  //Sign Out
  void signOut({
    required BuildContext context,
  }) async {
    state = true;
    final user = await _authRepository.signOut();
    state = false;
    user.fold(
      (l) {
        showSnackBar(context: context, text: l.message);
      },
      (r) async {
        await _ref.read(userProvider.notifier).update((state) => null);
        showSnackBar(context: context, text: "LogOut Successful!");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => SignInScreen()),
            (route) => false);
      },
    );
  }

  //save email only
  void saveEmail({
    required BuildContext context,
    required String email,
    required String uid,
  }) async {
    state = true;
    final res = await _authRepository.saveEmail(email: email, uid: uid);
    state = false;
    res.fold(
      (l) {
        showSnackBar(context: context, text: l.message);
      },
      (userModel) async {
        await _ref.read(userProvider.notifier).update((state) => userModel);
        Navigator.pushNamedAndRemoveUntil(
            context, BottomBar.routeName, (route) => false);
      },
    );
  }

//get current user data
  Stream<UserModel?> getUserData(String uid) {
    return _authRepository.getUserData(uid: uid);
  }

  //linkedIN error handling
  void linkedInErrorHandling({required String error}) {
    print("Linkedin Error: error");
  }
}
