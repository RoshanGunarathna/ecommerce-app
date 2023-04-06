// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../model/product.dart';
import 'product_card.dart';

class CustomGridView extends StatelessWidget {
  final String? categoryName;
  final List<ProductModel?> productList;
  const CustomGridView({
    Key? key,
    this.categoryName,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isProductNull = productList[0] == null;
    return SingleChildScrollView(
      child: Column(
        children: [
          (categoryName != null && isProductNull == false)
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
          isProductNull == false
              ? SizedBox(
                  height: 460,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 220,
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final product = productList[index];
                      return GestureDetector(
                        onTap: (() {}),
                        child: ProductCard(
                          product: product!,
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
