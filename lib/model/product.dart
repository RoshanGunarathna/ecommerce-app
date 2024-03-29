// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'category_model.dart';
import 'rating.dart';
import 'shipping_category_model.dart';

class ProductModel {
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
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.sellerUserId,
    required this.images,
    required this.price,
    required this.quantity,
    required this.kg,
    required this.shippingCategory,
    this.rating,
    this.discount,
    this.dateTime,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final productModel = ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category: List<CategoryModel>.from(
          map['category']?.map((res) => CategoryModel.fromMap(res))),
      sellerUserId: map['sellerUserId'] as String,
      images: List<String>.from(map['images']),
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      kg: map['kg'] != null ? map['kg'] as double : null,
      rating: map['rating'] != null
          ? List<Rating>.from(map['rating']?.map((res) => Rating.fromMap(res)))
          : null,
      discount: map['discount'] != null ? map['discount'] as int : null,
      dateTime:
          map['dateTime'] != null ? DateTime.parse(map['dateTime']) : null,
      shippingCategory: ShippingCategoryModel.fromMap(map['shippingCategory']),
    );

    return productModel;
  }

  static Map<String, dynamic> toMap({
    required ProductModel productModel,
    required List<String> searchKeyword,
  }) {
    return <String, dynamic>{
      'id': productModel.id,
      'name': productModel.name,
      'description': productModel.description,
      'category': productModel.category.map((category) {
        //Generate search Keywords
        final List<String> searchKeyword = [];
        final splittedMultipleWords = category.name.trim().split(" ");
        for (var element in splittedMultipleWords) {
          final String wordToLowercase = element.toLowerCase();
          for (var i = 1; i < wordToLowercase.length + 1; i++) {
            searchKeyword.add(wordToLowercase.substring(0, i));
          }
        }
        return CategoryModel.toMap(
            categoryModel: category, searchKeyword: searchKeyword);
      }).toList(),
      'sellerUserId': productModel.sellerUserId,
      'images': productModel.images,
      'price': productModel.price,
      'quantity': productModel.quantity,
      'rating': productModel.rating != null
          ? productModel.rating!.map((ratingModel) => Rating.toMap(ratingModel))
          : null,
      'kg': productModel.kg,
      'discount': productModel.discount,
      'searchKeyword': searchKeyword,
      'dateTime': productModel.dateTime.toString(),
      'shippingCategory': ShippingCategoryModel.toMap(
          shippingCategoryModel: productModel.shippingCategory),
    };
  }

  // List<String> generateSearchKeywords(String name) {
  //   //Generate search Keywords
  //   final List<String> searchKeyword = [];
  //   final splittedMultipleWords = name.trim().split(" ");
  //   for (var element in splittedMultipleWords) {
  //     final String wordToLowercase = element.toLowerCase();
  //     for (var i = 1; i < wordToLowercase.length + 1; i++) {
  //       searchKeyword.add(wordToLowercase.substring(0, i));
  //     }
  //   }
  //   return searchKeyword;
  // }
}
