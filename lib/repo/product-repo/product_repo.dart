// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:dart_frog_backend/models/product/product.dart';
import 'package:uuid/uuid.dart';


/// A [ProductRepo] is a repository for [Product]s.
class ProductRepo {
  /// Return a [Product] with the given [id]
  Future<Product?> productById(String id) async {
    ///
    return productsCache[id];
  }

  /// Returns a list of all [Product]s from data source.
  Future<Map<String, dynamic>> allProductsFromDataSource() async {
    final newMap = <String, dynamic>{};

    if (productsCache.isNotEmpty) {
      productsCache.forEach((key, value) {
        newMap[key] = value.toJson();
      });
    }

    return newMap;
  }

  /// Adds the given [product] to the repository.
  Future<String> addProduct(Product product) async {
    final id = const Uuid().v4();
    final newProduct = product.copyWith(id: id);
    productsCache[id] = newProduct;

    return id;
  }

  /// Deletes [Product] from the repository by [id].
  Future<void> deleteProduct(String id) async {
    productsCache.remove(id);
  }

  /// Updates [Product] from the repository by [id].
  Future<void> updateProduct(String id, Product product) async {
    final toBeUpdated = productsCache[id];

    if (toBeUpdated == null) {
      return Future.error(Exception('Product not found'));
    }

    productsCache[id] = product;
  }
}
