// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../core/palette.dart';
import '../../../model/product.dart';
import '../controller/cart_controller.dart';
import '../providers/cart_selected_item_provider.dart';

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
  bool _isCheckButtonPressed = true;

  void onPressedDelete() {
    ref.read(cartSelectedItemProvider.notifier).update((state) {
      if (state != null && state.isNotEmpty) {
        state.removeWhere((product) => product.id == widget.product.id);
      }
      return state;
    });

    ref.read(cartControllerProvider.notifier).removeAProductFromTheCartList(
        productID: widget.product.id, context: context);
  }

  void removeAProductFromTheSelectedProductCart(ProductModel product) {
    ref.read(cartSelectedItemProvider.notifier).update((state) {
      for (var i = 0; i < state!.length; i++) {
        if (state[i].id == product.id) {
          state.removeAt(i);
          break;
        }
      }
      return state;
    });
  }

  void addAProductFromTheSelectedProductCart(ProductModel product) {
    ref.read(cartSelectedItemProvider.notifier).update((state) {
      state!.add(product);

      return state;
    });
  }

  void selectionButtonPressed() {
    _isCheckButtonPressed
        ? addAProductFromTheSelectedProductCart(widget.product)
        : ref.read(cartSelectedItemProvider.notifier).update((state) {
            if (state != null && state.isNotEmpty) {
              state.removeWhere((product) => product.id == widget.product.id);
            }
            return state;
          });
  }

  void increaseQuantityButtonsPressed() {
    int lengthOfThisProduct = 0;
    final selectedProductList = ref.read(cartSelectedItemProvider);
    if (selectedProductList != null && selectedProductList.isNotEmpty) {
      //get ids
      final List<String> productIds = [];
      for (var element in selectedProductList) {
        productIds.add(element.id);
      }

      //remove selected product
      productIds.removeWhere((productId) => productId != widget.product.id);

      //get length of other product list
      lengthOfThisProduct = productIds.length;
    }

    if (_isCheckButtonPressed &&
        widget.product.quantity > lengthOfThisProduct) {
      addAProductFromTheSelectedProductCart(widget.product);
    }
  }

  void decreaseQuantityButtonsPressed() {
    int? lengthOfOtherProduct;
    final selectedProductList = ref.read(cartSelectedItemProvider);
    if (selectedProductList != null && selectedProductList.isNotEmpty) {
      //get ids
      final List<String> productIds = [];
      for (var element in selectedProductList) {
        productIds.add(element.id);
      }

      //remove selected product
      productIds.removeWhere((productId) => productId == widget.product.id);

      //get length of other product list
      lengthOfOtherProduct = productIds.length;
    }

    if (_isCheckButtonPressed &&
        lengthOfOtherProduct != null &&
        selectedProductList!.length > lengthOfOtherProduct + 1) {
      removeAProductFromTheSelectedProductCart(widget.product);
    } else if (_isCheckButtonPressed) {
      _isCheckButtonPressed = false;
      removeAProductFromTheSelectedProductCart(widget.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    const unselectedColor = grayColor;
    final selectedProductList = ref.watch(cartSelectedItemProvider);

    double kg = widget.product.kg ?? 1;
    if (selectedProductList != null && selectedProductList.isNotEmpty) {
      if (selectedProductList.isEmpty) {
        _isCheckButtonPressed = false;
      }
      List<ProductModel> selectedQuantity = [];

      for (var e in selectedProductList) {
        if (e.id == widget.product.id) {
          selectedQuantity.add(e);
        }
      }

      if (selectedQuantity.length > 1) {
        kg = widget.product.kg != null
            ? widget.product.kg! * selectedQuantity.length
            : 1.0 * selectedQuantity.length;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: blackColorShade2,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: _isCheckButtonPressed
                      ? Image.network(
                          widget.product.images[0],
                        )
                      : Image.network(
                          widget.product.images[0],
                          color: unselectedColor,
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 15,
                        color: _isCheckButtonPressed
                            ? blackColor
                            : unselectedColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '\$ ${widget.product.price}',
                      style: TextStyle(
                        fontSize: 15,
                        color: _isCheckButtonPressed
                            ? primaryColor
                            : unselectedColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: increaseQuantityButtonsPressed,
                          child: Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '+',
                              style: TextStyle(
                                color: _isCheckButtonPressed
                                    ? blackColor
                                    : unselectedColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          alignment: Alignment.center,
                          height: 18,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "$kg kg",
                            style: TextStyle(
                              fontSize: 10,
                              color: _isCheckButtonPressed
                                  ? blackColor
                                  : unselectedColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: decreaseQuantityButtonsPressed,
                          child: Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: whiteColor,
                            ),
                            child: Text(
                              '-',
                              style: TextStyle(
                                color: _isCheckButtonPressed
                                    ? blackColor
                                    : unselectedColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 40,
                width: 40,
                child: IconButton(
                  onPressed: onPressedDelete,
                  icon: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 1.7),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 7, right: 7),
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: RoundCheckBox(
                    animationDuration: const Duration(milliseconds: 0),
                    borderColor: grayColor,
                    checkedColor: primaryColor,
                    disabledColor: grayColor,
                    uncheckedWidget: const Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.mood_bad_rounded,
                        size: 15,
                      ),
                    ),
                    isChecked: _isCheckButtonPressed,
                    checkedWidget: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.done_rounded,
                        size: 13,
                      ),
                    ),
                    onTap: (tap) {
                      _isCheckButtonPressed = tap ?? true;

                      selectionButtonPressed();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
