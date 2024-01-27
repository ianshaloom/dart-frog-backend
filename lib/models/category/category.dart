import 'package:dart_frog_backend/models/product/product.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'category.g.dart';

/// A cache of [Category]s.
@visibleForTesting
Map<String, Category> categoriesCache = {};

/// A [Category] is a category of products.
@JsonSerializable()
class Category extends Equatable {
  /// A [Category] is a category of products.
  const Category({
    required this.id,
    required this.name,
    required this.products,
    this.description,
  });
  
  /// Deserializes a [Category] from json.
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
      
  /// The unique identifier of the category.
  final String id;
  /// The name of the category.
  final String name;
  /// The description of the category.
  final String? description;
  /// List of products in the category.
  final List<Product> products;
  
  /// a copy of the category with the given fields replaced with the new values.
  Category copyWith({
    String? id,
    String? name,
    String? description,
    List<Product>? products,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      products: products ?? this.products,      
    );
  }
  
  /// Serializes a [Category] to json.
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [id, name, description];
  
}
