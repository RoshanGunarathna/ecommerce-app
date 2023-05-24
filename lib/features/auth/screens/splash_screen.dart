import 'package:ecommerce_app/features/auth/controller/auth_controller.dart';
import 'package:ecommerce_app/features/favorite/controller/favorite_controller.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/error_text.dart';
import '../../../core/constants/assets_path.dart';

import '../../../model/user.dart';
import '../../cart/controller/cart_controller.dart';
import '../../home/widgets/bottom_bar.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenConsumerState();
}

class _SplashScreenConsumerState extends ConsumerState<SplashScreen> {
  UserModel? userModel;
  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .firstWhere((element) => element != null);

    if (userModel != null) {
      //update user
      ref.read(userProvider.notifier).update((state) => userModel);
      // update Favorite Product List
      // ignore: use_build_context_synchronously
      ref
          .read(favoriteControllerProvider.notifier)
          .updateFavoriteList(context: context);

      // update cart list
      //ignore: use_build_context_synchronously
      ref
          .read(cartControllerProvider.notifier)
          .updateCartList(context: context);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) {
            if (data != null) {
              getData(ref, data);
              if (userModel != null) {
                return const BottomBar();
                // return const CartScreen();
              }
            } else {
              return const SignInScreen();
            }
            return Scaffold(
              body: Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      logoPath,
                      fit: BoxFit.contain,
                    ),
                    // child: Container(
                    //   height: 50,
                    //   width: 50,
                    //   color: Colors.blue,
                    // ),
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(logoPath),
                ),
              ),
            );
          },
        );
  }
}
