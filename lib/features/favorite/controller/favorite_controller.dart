import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils.dart';
import '../../../model/product.dart';
import '../../../model/user.dart';

import '../../auth/controller/auth_controller.dart';
import '../repository/favorite_repository.dart';

//user provider
final favoriteProvider = StateProvider<List<ProductModel>?>((ref) => null);

//favoriteControllerProvider
final favoriteControllerProvider =
    StateNotifierProvider<FavoriteController, bool>(
  (ref) => FavoriteController(
    favoriteRepository: ref.watch(favoriteRepositoryProvider),
    ref: ref,
  ),
);

//get FavoriteProduct data future
final favoriteProductDataFutureProvider =
    FutureProvider.family<List<ProductModel>?, BuildContext>((ref, context) {
  final favoriteController = ref.watch(favoriteControllerProvider.notifier);
  return favoriteController.getFavoriteProductData(context);
});

class FavoriteController extends StateNotifier<bool> {
  final FavoriteRepository _favoriteRepository;
  final Ref _ref;
  FavoriteController(
      {required FavoriteRepository favoriteRepository, required Ref ref})
      : _favoriteRepository = favoriteRepository,
        _ref = ref,
        super(false);

  //set favoriteProduct list
  Future<bool> setFavoriteProductData({
    required ProductModel product,
    required BuildContext context,
  }) async {
    bool returnValue = false;
    state = true;
    final res = await _favoriteRepository.setFavoriteProductData(
        _ref.read(userProvider)!.id, product);
    state = false;
    res.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (isOver) {
      returnValue = isOver;
      if (isOver) {
        getFavoriteProductData(context);
      }
    });
    return returnValue;
  }

  //get favoriteProduct list
  Future<List<ProductModel>?> getFavoriteProductData(
      BuildContext context) async {
    List<ProductModel>? returnValue;

    final res = await _favoriteRepository
        .getFavoriteProduct(_ref.read(userProvider)!.id);

    res.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (favoriteList) {
      returnValue = favoriteList;
      _ref.read(favoriteProvider.notifier).update((state) => favoriteList);
    });

    return returnValue;
  }

  //get User data

  Future<UserModel?> getUserData({
    required BuildContext context,
  }) async {
    UserModel? returnValue;
    state = true;
    final res =
        await _favoriteRepository.getUserData(uid: _ref.read(userProvider)!.id);
    state = false;
    res.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (user) {
      returnValue = user;
    });
    return returnValue;
  }

  //remove a product from the favorite product list

  Future<bool> removeAProductFromTheFavoriteList({
    required String productID,
    required BuildContext context,
  }) async {
    bool returnValue = false;
    state = true;
    final res = await _favoriteRepository.removeAProductFromTheFavoriteList(
      uid: _ref.read(userProvider)!.id,
      productId: productID,
    );
    state = false;
    res.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (isOK) {
      returnValue = isOK;
      updateFavoriteList(context: context);
    });
    return returnValue;
  }

//Update Favorite List
  void updateFavoriteList({required BuildContext context}) {
    _ref
        .read(favoriteControllerProvider.notifier)
        .getFavoriteProductData(context)
        .then((favoriteProductList) => _ref
            .read(favoriteProvider.notifier)
            .update((state) => favoriteProductList));
  }
}
