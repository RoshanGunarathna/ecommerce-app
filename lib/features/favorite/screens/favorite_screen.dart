import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import '../../home/widgets/bottom_bar.dart';
import '../services/image_services.dart';
import '../widgets/customGridView.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final List<String> images = [];

  void getImages() async {
    final ImageServices imageServices = ImageServices();
    final List<String> imgUrl = await imageServices.getRandomImages();
    images.addAll(imgUrl);
    setState(() {
      images;
    });
  }

  @override
  void initState() {
    getImages();
    super.initState();
  }

  void backtoHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
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
      body: CustomGridView(isHomeScreen: false, images: images),
    );
  }
}
