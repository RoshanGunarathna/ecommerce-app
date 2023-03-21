// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/enums/enums.dart';
import '../../../theme/pallete.dart';
import '../controller/auth_controller.dart';

class SocialButton extends ConsumerWidget {
  final String iconPath;
  final String label;
  final double horizontalPadding;
  final double verticalPadding;
  final SocialButtonType socialButtonType;
  const SocialButton(
      {Key? key,
      required this.iconPath,
      required this.label,
      required this.socialButtonType,
      this.horizontalPadding = 10,
      this.verticalPadding = 10})
      : super(key: key);

//Google sign-in
  void signInWithGoogle(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

//facebook sign-in
  void signInWithFacebook(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInWithFacebook(context);
  }

//linkedIn sign-in
  void signInWithLinkedIn(WidgetRef ref, BuildContext context) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      iconSize: 30,
      onPressed: () {
        socialButtonType == SocialButtonType.facebook
            ? signInWithFacebook(ref, context)
            : socialButtonType == SocialButtonType.google
                ? signInWithGoogle(ref, context)
                : signInWithLinkedIn(ref, context);
      },
      icon: Image.asset(
        iconPath,
      ),
    );
  }
}
