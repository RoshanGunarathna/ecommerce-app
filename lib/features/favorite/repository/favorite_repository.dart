import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/firebase_constants.dart';

import '../../../../core/providers/firebase_providers.dart';
import '../../../core/failure.dart';

import '../../../core/type_defs.dart';
import '../../../model/product.dart';
import '../../../model/user.dart';

final favoriteRepositoryProvider = Provider(
  (ref) => FavoriteRepository(
    firestore: ref.read(firestoreProvider),
  ),
);

class FavoriteRepository {
  final FirebaseFirestore _firestore;

  FavoriteRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.userCollection);

  //add Product To Favorite Product List
  FutureEither<bool> setFavoriteProductData(
      String uid, ProductModel product) async {
    try {
      List<ProductModel>? favoriteProductList = [];
      UserModel? userModel;

      final res = await getUserData(uid: uid);
      res.fold((l) => throw (l.message), (r) {
        favoriteProductList = r.favorite ?? [];
        userModel = r;
      });

      if (userModel != null) {
        favoriteProductList!.add(product);

        final UserModel user =
            userModel!.copyWith(favorite: favoriteProductList);

        //generate Search keywords
        final List<String> searchKeyword = [];
        final splittedMultipleWords = user.name.trim().split(" ");
        for (var element in splittedMultipleWords) {
          final String wordToLowercase = element.toLowerCase();
          for (var i = 1; i < wordToLowercase.length + 1; i++) {
            searchKeyword.add(wordToLowercase.substring(0, i));
          }

          final finalUser =
              UserModel.toMap(userModel: user, searchKeyword: searchKeyword);

          await _users.doc(uid).set(finalUser);
          return right(true);
        }
      }
      return right(false);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //get Favorite Product List
  FutureEither<List<ProductModel>?> getFavoriteProduct(String uid) async {
    try {
      List<ProductModel>? favoriteProductList;
      final user = await getUserData(uid: uid);
      user.fold(
          (l) => throw (l.message), (r) => favoriteProductList = r.favorite);
      if (favoriteProductList == null ||
          favoriteProductList!.isEmpty ||
          favoriteProductList!.contains(null)) {
        favoriteProductList = null;
      }
      return right(favoriteProductList);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //get user data
  FutureEither<UserModel> getUserData({required String uid}) async {
    try {
      final getUser = await _users.doc(uid).get();
      final user = UserModel.fromMap(getUser.data() as Map<String, dynamic>);
      return right(user);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //remove an product from a favorite product list
  FutureEither<bool> removeAProductFromTheFavoriteList(
      {required String uid, required String productId}) async {
    try {
      bool returnValue = false;

      List<ProductModel?>? favoriteProductList = [];
      UserModel? userModel;

      final res = await getUserData(uid: uid);
      res.fold((l) => throw (l.message), (r) {
        favoriteProductList = r.favorite ?? [];
        userModel = r;
      });

      if (userModel != null) {
        for (var i = 0; i < favoriteProductList!.length; i++) {
          if (favoriteProductList![i]!.id == productId) {
            favoriteProductList!.removeAt(i);
          }
        }
        favoriteProductList!.removeWhere((element) => element == null);
        _users.doc(uid).update({
          'favorite': favoriteProductList!.map((product) {
            //Generate search Keywords
            final List<String> searchKeyword = [];
            final splittedMultipleWords = product!.name.trim().split(" ");
            for (var element in splittedMultipleWords) {
              final String wordToLowercase = element.toLowerCase();
              for (var i = 1; i < wordToLowercase.length + 1; i++) {
                searchKeyword.add(wordToLowercase.substring(0, i));
              }
            }
            return ProductModel.toMap(
                productModel: product, searchKeyword: searchKeyword);
          }).toList()
        });

        returnValue = true;
      }
      return right(returnValue);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
