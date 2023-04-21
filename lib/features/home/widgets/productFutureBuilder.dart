import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product.dart';
import '../controller/home_controller.dart';
import 'customGridView.dart';

class ProductStramBuilder extends ConsumerWidget {
  final String? category;

  const ProductStramBuilder({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.all(17.0),
        child: category == null
            ? FutureBuilder(
                future: ref
                    .watch(homeControllerProvider.notifier)
                    .getAllProductData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return whenLoading();
                  } else if (snapshot.hasError) {
                    return whenError(snapshot.error);
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return whenData(snapshot);
                  } else {
                    return const SizedBox();
                  }
                })
            : ref
                .watch(homeControllerProvider.notifier)
                .getCategorizedProductData(category: category!)
                .when(
                    data: (snapshot) => whenData(snapshot),
                    error: (error, stackTrace) => whenError(error),
                    loading: () => whenLoading()));
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
                productList: products, categoryName: category ?? "Trending"),
          )
        : const SizedBox();
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
