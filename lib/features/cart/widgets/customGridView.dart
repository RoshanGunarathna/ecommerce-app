// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../model/product.dart';
import 'product_card.dart';

class CustomGridView extends StatelessWidget {
  final List<ProductModel> productList;
  final VoidCallback? onTapFavoriteButton;
  const CustomGridView({
    Key? key,
    required this.productList,
    this.onTapFavoriteButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 120,
          crossAxisCount: 1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 5),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return GestureDetector(
          onTap: (() {}),
          child: ProductCard(
            product: product,
          ),
        );
      },
    );
  }
}
