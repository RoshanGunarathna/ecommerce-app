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

  void signInWithGoogle(WidgetRef ref) {
    ref.read(authControllerProvider).signInWithGoogel();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: () {
        socialButtonType == SocialButtonType.facebook
            ? () {}
            : signInWithGoogle(ref);
      },
      icon: SvgPicture.asset(
        iconPath,
        width: 25,
        color: Palette.whiteColor,
      ),
      label: Text(label),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Palette.borderColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
