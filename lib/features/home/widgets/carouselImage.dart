import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'offer.dart';

class CarouselImage extends StatelessWidget {
  final List<String> images;
  const CarouselImage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map((i) {
        return Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                i,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: const Offer(),
        );
      }).toList(),
      options: CarouselOptions(viewportFraction: 1, height: 160),
    );
  }
}
