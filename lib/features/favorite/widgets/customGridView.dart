// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'product_card.dart';

class CustomGridView extends StatelessWidget {
  final String? categoryName;
  final bool isHomeScreen;
  final List<String> images;
  const CustomGridView({
    Key? key,
    this.categoryName,
    required this.isHomeScreen,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 220,
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return GestureDetector(
            onTap: (() {}),
            child: ProductCard(
              image: image,
            ),
          );
        },
      ),
    );
  }
}
