// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product.dart';
import '../controller/favorite_controller.dart';
import 'customGridView.dart';

class ProductFutureBuilder extends ConsumerWidget {
  final VoidCallback? onTapFavoriteButton;
  const ProductFutureBuilder({
    Key? key,
    this.onTapFavoriteButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: ref.watch(favoriteProductDataFutureProvider(context)).when(
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
  Widget whenData(List<ProductModel>? snapshot) {
    List<ProductModel>? products = snapshot;

    bool isHaveData = false;
    if (products != null && products.isNotEmpty && !products.contains(null)) {
      isHaveData = true;
    }

    return isHaveData
        ? Padding(
            padding: const EdgeInsets.all(4.0),
            child: CustomGridView(
                productList: products!,
                onTapFavoriteButton: onTapFavoriteButton),
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
