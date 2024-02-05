import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subcategory.g.dart';

@JsonSerializable()
  class SubCategory extends Equatable {
  const SubCategory({
    required this.id,
    required this.name,
    required this.productIds,
  });

  final String id;
  final String name;
  final List<String> productIds;

    // Deserializes a [Product] from json.
  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  // Serializes this [Product] to json.
  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);

  // a copy of the product with the given fields replaced with the new values.
  SubCategory copyWith({
    String? id,
    String? name,
    List<String>? productIds,
  }) {
    return SubCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      productIds: productIds ?? this.productIds,
    );
  }


  @override
  List<Object?> get props => [id, name, productIds];
}
