import 'package:ecommerce_app/features/auth/controller/auth_controller.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/image_services.dart';
import '../widgets/carouselImage.dart';
import '../widgets/search.dart';
import '../widgets/customGridView.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenConsumerState();
}

class _HomeScreenConsumerState extends ConsumerState<HomeScreen> {
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
    final userData = ref.watch(userProvider);
    final UserModel user = userData ??
        UserModel(
            id: '-',
            name: 'guest',
            address: '',
            email: '',
            photoUrl: "",
            cart: []);

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
              Text(
                "Hello ${user.name}",
                style: const TextStyle(fontSize: 15),
              ),
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
