import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'product.g.dart';

@JsonSerializable()

/// A [Product] is a product that can be sold.
class Product extends Equatable {
  /// A [Product] is a product that can be sold.
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.unitOfMeasurement,
    this.categoryId,
    this.imageUrl,
  });

  /// Deserializes a [Product] from json.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// The unique identifier of the product.
  final String id;

  /// The name of the product.
  final String name;

  /// The price of the product.
  final double price;

  /// The description of the product.
  final String description;

  /// The category of the product.
  final String? categoryId;

  /// The unit of measurement of the product.
  final String unitOfMeasurement;

  /// The image url of the product.
  final String? imageUrl;

  /// a copy of the product with the given fields replaced with the new values.
  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? categoryId,
    String? unitOfMeasurement,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      unitOfMeasurement: unitOfMeasurement ?? this.unitOfMeasurement,
      categoryId: categoryId ?? this.categoryId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  /// Serializes this [Product] to json.
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props =>
      [id, name, price, description, categoryId, unitOfMeasurement, imageUrl];
}

/// in cache
@visibleForTesting
Map<String, Product> productsCache = {};
