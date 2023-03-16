import 'package:flutter/material.dart';
import 'package:scroll_navigation/scroll_navigation.dart';

import '../../../core/palette.dart';
import '../../home/widgets/bottom_bar.dart';
import '../services/image_services.dart';
import '../widgets/customGridView.dart';

import '../widgets/search.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 50),
        child: Column(
          children: [
            AppBar(
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
                "Categories",
                style: TextStyle(color: blackColorShade1, fontSize: 25),
              ),
              elevation: 0,
            ),
            const Search(),
          ],
        ),
      ),
      body: TitleScrollNavigation(
        identiferStyle: const NavigationIdentiferStyle(
            color: blackColor, position: IdentifierPosition.topAndRight),
        showIdentifier: true,
        barStyle: const TitleNavigationBarStyle(
            style: TextStyle(fontSize: 15),
            elevation: 0,
            activeColor: blackColor,
            padding: EdgeInsets.all(3),
            spaceBetween: 30),
        titles: const [
          "All",
          "Fruits",
          "Drinks",
          "Vegetables",
          "Meat",
          "other"
        ],
        pages: [
          CustomGridView(isHomeScreen: false, images: images),
          CustomGridView(isHomeScreen: false, images: images),
          CustomGridView(isHomeScreen: false, images: images),
          CustomGridView(isHomeScreen: false, images: images),
          CustomGridView(isHomeScreen: false, images: images),
          CustomGridView(isHomeScreen: false, images: images),
        ],
      ),
    );
  }
}
