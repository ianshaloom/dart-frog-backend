import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../subcategory/subcategory.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {

  const Category({
    required this.id,
    required this.name,
    required this.subCategory,
    required this.productIds,
  });


  final String id;
  final String name;
  final List<SubCategory> subCategory;
  final List<String> productIds;

  // Deserializes a [Product] from json.
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  // Serializes this [Product] to json.
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  // a copy of the product with the given fields replaced with the new values.
  Category copyWith({
    String? id,
    String? name,
    List<SubCategory>? subCategory,
    List<String>? productIds,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      subCategory: subCategory ?? this.subCategory,
      productIds: productIds ?? this.productIds,
    );
  }

@override
  List<Object?> get props => [id, name, subCategory, productIds];

  }

