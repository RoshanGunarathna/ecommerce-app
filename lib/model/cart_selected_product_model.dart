// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'category_model.dart';
import 'rating.dart';
import 'shipping_category_model.dart';

class CartSelectedProductModel {
  final String id;
  final String name;
  final String description;
  final List<CategoryModel> category;
  final String sellerUserId;
  final List<String> images;
  final double price;
  final int quantity;
  final List<Rating>? rating;
  final double? kg;
  final int? discount;
  final DateTime? dateTime;
  final ShippingCategoryModel shippingCategory;
  final bool isSelected;
  final int selectedQuantity;

  CartSelectedProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.sellerUserId,
    required this.images,
    required this.price,
    required this.quantity,
    this.rating,
    required this.kg,
    this.discount,
    this.dateTime,
    required this.shippingCategory,
    required this.isSelected,
    required this.selectedQuantity,
  });

  CartSelectedProductModel copyWith({
    String? id,
    String? name,
    String? description,
    List<CategoryModel>? category,
    String? sellerUserId,
    List<String>? images,
    double? price,
    int? quantity,
    List<Rating>? rating,
    double? kg,
    int? discount,
    DateTime? dateTime,
    ShippingCategoryModel? shippingCategory,
    bool? isSelected,
    int? selectedQuantity,
  }) {
    return CartSelectedProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      sellerUserId: sellerUserId ?? this.sellerUserId,
      images: images ?? this.images,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      rating: rating ?? this.rating,
      kg: kg ?? this.kg,
      discount: discount ?? this.discount,
      dateTime: dateTime ?? this.dateTime,
      shippingCategory: shippingCategory ?? this.shippingCategory,
      isSelected: isSelected ?? this.isSelected,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
    );
  }
}
