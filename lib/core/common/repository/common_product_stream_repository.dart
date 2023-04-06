import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/categories/widgets/product_card.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/category_model.dart';
import '../../../model/product.dart';
import '../../constants/firebase_constants.dart';

import '../../providers/firebase_providers.dart';

final commonProductStreamRepositoryProvider = Provider(
  (ref) => CommonProductStreamRepository(
    firestore: ref.read(firestoreProvider),
  ),
);

class CommonProductStreamRepository {
  final FirebaseFirestore _firestore;
  CommonProductStreamRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productCollection);

  //get All product data
  Stream<List<ProductModel>> getAllProductData() {
    return _products.snapshots().map((snap) => snap.docs.map((product) {
          return ProductModel.fromMap(product.data() as Map<String, dynamic>);
        }).toList());
  }

  //get Categorized product data
  Stream<List<ProductModel?>> getCategorizedProductData(String category) {
    final productData = _products.snapshots().map((snap) => snap.docs.map((e) {
          final product =
              ProductModel.fromMap(e.data() as Map<String, dynamic>);
          for (var element in product.category) {
            if (element.name == category) {
              return product;
            }
          }
        }).toList());
    print(productData.runtimeType);
    return productData;
  }

  //get Categorized product data
  Stream<List<ProductModel>> getDiscountedProductData() {
    final productData = _products
        .where("discount", isNull: false)
        .snapshots()
        .map((snap) => snap.docs.map((e) {
              return ProductModel.fromMap(e.data() as Map<String, dynamic>);
            }).toList());

    return productData;
  }
}
