import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/palette.dart';

import '../../home/widgets/bottom_bar.dart';

import '../widgets/productFutureBuilder.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenConsumerState();
}

class _FavoriteScreenConsumerState extends ConsumerState<FavoriteScreen> {
  void backtoHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: backtoHome,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: blackColorShade1,
            size: 35,
          ),
        ),
        title: const Text(
          "Favorite",
          style: TextStyle(color: blackColorShade1, fontSize: 25),
        ),
        elevation: 0,
      ),
      body: ProductFutureBuilder(onTapFavoriteButton: refresh),
    );
  }
}
