import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product.dart';
import '../../constants/firebase_constants.dart';

import '../../providers/firebase_providers.dart';

final commonGetProductRepositoryProvider = Provider(
  (ref) => CommonGetProductRepository(
    firestore: ref.read(firestoreProvider),
  ),
);

class CommonGetProductRepository {
  final FirebaseFirestore _firestore;
  CommonGetProductRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productCollection);

  //get All product data
  Future<List<ProductModel>> getAllProductData() async {
    try {
      final res = await _products.get();
      final products = res.docs
          .map((product) =>
              ProductModel.fromMap(product.data() as Map<String, dynamic>))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //get Categorized product data
  Future<List<ProductModel?>> getCategorizedProductData(String category) async {
    print(" CommonGetCategorizedProductData is initialized");
    try {
      final res = await _products.get();
      final productList = res.docs.map((e) {
        final value = e.data() as Map<String, dynamic>;

        final product = ProductModel.fromMap(value);
        for (var element in product.category) {
          if (element.name == category) {
            return product;
          }
        }
      }).toList();

      productList.removeWhere((element) => element == null);
      return productList;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //get Discounted product data
  Future<List<ProductModel>> getDiscountedProductData() async {
    try {
      final res = await _products.where("discount", isNull: false).get();
      final productData = res.docs.map((e) {
        return ProductModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
      return productData;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
