import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Stream<List<ProductModel>> getCategorizedProductData(String category) {
    return _products.where('category', isEqualTo: [category]).snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((product) =>
                ProductModel.fromMap(product.data() as Map<String, dynamic>))
            .toList());
  }
}
