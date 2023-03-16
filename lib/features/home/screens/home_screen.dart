import 'package:flutter/material.dart';

import '../services/image_services.dart';
import '../widgets/carouselImage.dart';
import '../widgets/search.dart';
import '../widgets/customGridView.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Search(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              CarouselImage(images: images),
              const SizedBox(
                height: 10,
              ),
              CustomGridView(
                images: images,
                isHomeScreen: true,
                categoryName: 'Fresh Food',
              ),
              const SizedBox(
                height: 15,
              ),
              CustomGridView(
                images: images,
                isHomeScreen: true,
                categoryName: 'Vegitables',
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
