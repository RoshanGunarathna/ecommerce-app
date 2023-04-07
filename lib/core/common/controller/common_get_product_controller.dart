import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product.dart';
import '../repository/common_get_product_repository.dart';

//authControllerProvider
final commonGetProductControllerProvider =
    StateNotifierProvider<CommonGetProductController, bool>(
  (ref) => CommonGetProductController(
    commonGetProductRepository: ref.watch(commonGetProductRepositoryProvider),
    ref: ref,
  ),
);

//future provider for get the categorized data
final categorizedProductListProvider =
    FutureProvider.family<List<ProductModel?>, String>((ref, category) {
  final authController = ref.watch(commonGetProductControllerProvider.notifier);
  return authController.getCategorizedProductData(category: category);
});

class CommonGetProductController extends StateNotifier<bool> {
  final CommonGetProductRepository _commonGetProductRepository;
  final Ref _ref;
  CommonGetProductController(
      {required CommonGetProductRepository commonGetProductRepository,
      required Ref ref})
      : _commonGetProductRepository = commonGetProductRepository,
        _ref = ref,
        super(false);

  //get all Products
  Future<List<ProductModel>> getAllProductData() async {
    final productList = await _commonGetProductRepository.getAllProductData();

    return productList;
  }

  //get Discounted Products
  Future<List<ProductModel>> getDiscountedProductData() async {
    final productList =
        await _commonGetProductRepository.getDiscountedProductData();

    return productList;
  }

  //get Categorized Products
  Future<List<ProductModel?>> getCategorizedProductData({
    required String category,
  }) async {
    print("categorzed");
    final productList =
        await _commonGetProductRepository.getCategorizedProductData(category);

    return productList;
  }
}
