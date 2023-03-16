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
    return Column(
      children: [
        (isHomeScreen && categoryName != null)
            ? Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 12,
                ),
                child: Text(
                  categoryName!,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: 460,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
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
        ),
      ],
    );
  }
}
