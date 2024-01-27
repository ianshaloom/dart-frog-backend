// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      unitOfMeasurement: json['unitOfMeasurement'] as String,
      categoryId: json['categoryId'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'unitOfMeasurement': instance.unitOfMeasurement,
      'imageUrl': instance.imageUrl,
    };
