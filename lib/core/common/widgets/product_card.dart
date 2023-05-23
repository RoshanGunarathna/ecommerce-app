// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/features/cart/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_app/model/product.dart';

import '../../../core/palette.dart';
import '../../../features/cart/controller/cart_controller.dart';
import '../../../features/favorite/controller/favorite_controller.dart';

class ProductCard extends ConsumerStatefulWidget {
  final ProductModel product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  ConsumerState<ProductCard> createState() => _ProductCardConsumerState();
}

class _ProductCardConsumerState extends ConsumerState<ProductCard> {
  bool isThisFavorite = false;
  bool isCartMethodRunning = false;

  void addToFavoriteList() async {
    final isAdded = await ref
        .read(favoriteControllerProvider.notifier)
        .setFavoriteProductData(product: widget.product, context: context);
    if (isAdded) {
      isThisFavorite = true;
    }
  }

  void addToCart() async {
    print(isCartMethodRunning);
    if (isCartMethodRunning == false) {
      final isAdded = await ref
          .read(cartControllerProvider.notifier)
          .addToCart(product: widget.product, context: context);
    }
  }

  Future<bool> removeAProductFromAFavoriteList() async {
    final isDeleted = await ref
        .read(favoriteControllerProvider.notifier)
        .removeAProductFromTheFavoriteList(
            productID: widget.product.id, context: context);
    return isDeleted;
  }

  void favoriteButtonPress() async {
    if (isThisFavorite == false) {
      isThisFavorite = true;
      addToFavoriteList();
    } else {
      isThisFavorite = false;
      final isDeleted = await removeAProductFromAFavoriteList();
    }
  }

  void navigateToCartScreen() {
    Navigator.pushNamed(context, CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    isCartMethodRunning = ref.watch(cartControllerProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: blackColorShade2,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Image.network(
                    widget.product.images[0],
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: primaryColor.withOpacity(0.08),
                        ),
                        child: IconButton(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(0),
                          color: primaryColor,
                          onPressed: favoriteButtonPress,
                          icon: getFavoriteIcon(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name.length > 12
                            ? "${widget.product.name.substring(0, 10)}.."
                            : widget.product.name,
                        style: const TextStyle(
                            color: blackColorShade1,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      RichText(
                        text: TextSpan(
                            text:
                                '\$${widget.product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: '',
                                  style: TextStyle(color: blackColorShade1))
                            ]),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  getAddIcon(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Icon getFavoriteIcon() {
    final favoriteList = ref.watch(favoriteProvider);

    Icon icon = const Icon(Icons.favorite_outline_rounded);

    if (favoriteList.isNotEmpty) {
      for (var e in favoriteList) {
        if (e.id == widget.product.id) {
          icon = const Icon(Icons.favorite_rounded);
          isThisFavorite = true;
        }
      }
    }

    return icon;
  }

  Widget getAddIcon() {
    final cart = ref.watch(cartProvider);
    bool isThisAddedToCart = false;
    Widget returnWidget = Container(
      height: 28,
      width: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: primaryColor,
      ),
      child: IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: addToCart,
        icon: const Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );

    if (cart.isNotEmpty) {
      for (var product in cart) {
        isThisAddedToCart = product.id == widget.product.id;
        if (isThisAddedToCart) {
          returnWidget = Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: primaryColor,
            ),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: navigateToCartScreen,
              icon: const Icon(
                Icons.shopping_bag_rounded,
                color: whiteColor,
                size: 16,
              ),
            ),
          );
        }
      }
    }

    return returnWidget;
  }
}
