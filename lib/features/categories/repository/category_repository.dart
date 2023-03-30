import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/common_product_stream_repository.dart';
import '../../../core/constants/firebase_constants.dart';

import '../../../core/providers/firebase_providers.dart';
import '../../../model/product.dart';

final categoryRepositoryProvider = Provider(
  (ref) => CategoryRepository(
    firestore: ref.read(firestoreProvider),
  ),
);

class CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productCollection);

//get all product data
  Stream<List<ProductModel>> getAllProductData(Ref ref) {
    return ref.watch(commonProductStreamRepositoryProvider).getAllProductData();
  }

  //get categorized product data
  Stream<List<ProductModel>> getCategorizedProductData({
    required Ref ref,
    required String category,
  }) {
    return ref
        .watch(commonProductStreamRepositoryProvider)
        .getCategorizedProductData(category);
  }
}
