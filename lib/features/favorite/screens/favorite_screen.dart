import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/palette.dart';

import '../../home/widgets/bottom_bar.dart';

import '../controller/favorite_controller.dart';
import '../widgets/customGridView.dart';

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

  void favoriteProductListRefresh() {
    ref
        .read(favoriteControllerProvider.notifier)
        .updateFavoriteList(context: context);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      favoriteProductListRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProductList = ref.watch(favoriteProvider);
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
      body: favoriteProductList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomGridView(
                productList: favoriteProductList,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Icon(
                      Icons.mood_bad_rounded,
                      size: 100,
                      color: Color.fromARGB(255, 226, 226, 226),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('No products'),
                ],
              ),
            ),
    );
  }
}
