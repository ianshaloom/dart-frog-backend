import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../category/category.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  const Product({
    required this.id,
    required this.productName,
    required this.category,
    required this.brand,
    required this.size,
    required this.color,
    required this.material,
    required this.purchasePrice,
    required this.discountedPrice,
    required this.sellingPrice,
    required this.photos,
    required this.stock,
  });

// general details
  final String id;
  final String productName;
  final Category? category;

  // more details
  final String? brand;
  final String? size;
  final String? color;
  final String? material;

  // price
  final double? discountedPrice;
  final double purchasePrice;
  final double sellingPrice;

  // photos
  final List<String> photos;

  // stock
  final int stock;

  // Deserializes a [Product] from json.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  // Serializes this [Product] to json.
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  // a copy of the product with the given fields replaced with the new values.
  Product copyWith({
    String? id,
    String? productName,
    Category? category,
    String? brand,
    String? size,
    String? color,
    String? material,
    double? purchasePrice,
    double? discountedPrice,
    double? sellingPrice,
    List<String>? photos,
    int? stock,
  }) {
    return Product(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      size: size ?? this.size,
      color: color ?? this.color,
      material: material ?? this.material,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      photos: photos ?? this.photos,
      stock: stock ?? this.stock,
    );
  }

  

  @override
  List<Object?> get props => [
        id,
        productName,
        category,
        brand,
        size,
        color,
        material,
        purchasePrice,
        discountedPrice,
        sellingPrice,
        photos,
        stock,
      ];
}
