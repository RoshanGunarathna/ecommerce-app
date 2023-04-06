import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product.dart';
import '../controller/home_controller.dart';
import 'carouselImage.dart';

class CarouselStramBuilder extends ConsumerWidget {
  const CarouselStramBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: StreamBuilder(
          stream: ref
              .watch(homeControllerProvider.notifier)
              .getDiscountedProductData(),
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
              List<ProductModel> products = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: CarouselImage(discountedProductList: products),
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
