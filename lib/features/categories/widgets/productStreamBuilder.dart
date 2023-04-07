import 'package:ecommerce_app/features/categories/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/controller/common_get_category_controller.dart';
import '../../../core/common/controller/common_get_product_controller.dart';
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
      child: categoryName == null
          ? FutureBuilder(
              future: ref
                  .watch(categoryControllerProvider.notifier)
                  .getAllProductData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return whenLoading();
                } else if (snapshot.hasError) {
                  return whenError(snapshot.error);
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return whenData(snapshot);
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: Icon(
                            Icons.mood_bad_rounded,
                            size: 100,
                            color: Color.fromARGB(255, 226, 226, 226),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('No products'),
                      ],
                    ),
                  );
                }
              })
          : ref
              .read(categoryControllerProvider.notifier)
              .getCategorizedProductData(category: categoryName!)
              .when(
                  data: (snapshot) => whenData(snapshot),
                  error: (error, stackTrace) => whenError(error),
                  loading: () => whenLoading()),
    );
  }

  //when error
  Widget whenError(dynamic error) {
    return Center(
      child: Text('Something went wrong! ${error}'),
    );
  }

  //when data
  Widget whenData(dynamic snapshot) {
    List<ProductModel?> products = snapshot.runtimeType == (List<ProductModel?>)
        ? snapshot
        : snapshot.data;

    return products.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(4.0),
            child: CustomGridView(
                productList: products, categoryName: categoryName),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Icon(
                    Icons.mood_bad_rounded,
                    size: 100,
                    color: Color.fromARGB(255, 226, 226, 226),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('No products'),
              ],
            ),
          );
  }

  //when loading
  Widget whenLoading() {
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
  }
}
