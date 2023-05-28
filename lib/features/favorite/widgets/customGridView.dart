// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/common/widgets/product_card.dart';
import '../../../model/product.dart';

class CustomGridView extends StatelessWidget {
  final List<ProductModel> productList;

  const CustomGridView({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: size.width / (size.height / 4),
              mainAxisExtent: size.height / 4,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
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
          )
        ],
      ),
    );
  }
}
