import 'package:ecommerce_app/features/categories/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product.dart';
import 'customGridView.dart';

class ProductStramBuilder extends ConsumerWidget {
  final String? categoryName;

  const ProductStramBuilder({
    Key? key,
    this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: StreamBuilder(
          stream: categoryName != null
              ? ref
                  .watch(categoryControllerProvider.notifier)
                  .getCategorizedProductData(category: categoryName!)
              : ref
                  .watch(categoryControllerProvider.notifier)
                  .getAllProductData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(
                      height: 20,
                    ),
                    Text('We are Loading..'),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong! ${snapshot.error}'),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<ProductModel?> products = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomGridView(
                    productList: products, categoryName: categoryName),
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
