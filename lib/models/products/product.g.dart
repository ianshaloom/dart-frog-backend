// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      productName: json['productName'] as String,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      brand: json['brand'] as String?,
      size: json['size'] as String?,
      color: json['color'] as String?,
      material: json['material'] as String?,
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      discountedPrice: (json['discountedPrice'] as num?)?.toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      stock: json['stock'] as int,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'category': instance.category,
      'brand': instance.brand,
      'size': instance.size,
      'color': instance.color,
      'material': instance.material,
      'discountedPrice': instance.discountedPrice,
      'purchasePrice': instance.purchasePrice,
      'sellingPrice': instance.sellingPrice,
      'photos': instance.photos,
      'stock': instance.stock,
    };
