import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../model/product.dart';
import 'offer.dart';

class CarouselImage extends StatelessWidget {
  final List<ProductModel> discountedProductList;
  const CarouselImage({super.key, required this.discountedProductList});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: discountedProductList.map((product) {
        return Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                product.images[0],
              ),
              fit: BoxFit.contain,
            ),
          ),
          child: Offer(product: product),
        );
      }).toList(),
      options: CarouselOptions(viewportFraction: 1, height: 160),
    );
  }
}
