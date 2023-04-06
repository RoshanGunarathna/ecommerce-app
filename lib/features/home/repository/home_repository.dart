import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/controller/common_get_category_controller.dart';
import '../../../core/common/repository/common_product_stream_repository.dart';

import '../../../model/product.dart';

final homeRepositoryProvider = Provider((ref) => HomeRepository());

class HomeRepository {
//get all product data
  Stream<List<ProductModel>> getAllProductData(Ref ref) {
    return ref.watch(commonProductStreamRepositoryProvider).getAllProductData();
  }

  //get categorized product data
  Stream<List<ProductModel?>> getCategorizedProductData({
    required Ref ref,
    required String category,
  }) {
    return ref
        .watch(commonProductStreamRepositoryProvider)
        .getCategorizedProductData(category);
  }

  //get Discounted product data
  Stream<List<ProductModel>> getDiscountedProductData({
    required Ref ref,
  }) {
    return ref
        .watch(commonProductStreamRepositoryProvider)
        .getDiscountedProductData();
  }

  //get Category list
  Future<bool> getCategoryData(
      {required Ref ref, required BuildContext context}) async {
    return await ref
        .read(commonGetCategoryControllerProvider.notifier)
        .getCategoryData(context);
  }
}
