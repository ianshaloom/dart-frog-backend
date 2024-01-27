// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:dart_frog_backend/models/category/category.dart';
import 'package:uuid/uuid.dart';

/// A [CategoryRepo] is a repository for [Category]s.
class CategoryRepo {
  /// Return a [Category] with the given [id]
  Future<Category?> categoryById(String id) async {
    ///
    return categoriesCache[id];
  }

  /// Returns a list of all [Category]s from data source.
  Future<Map<String, dynamic>> allCategoriesFromDataSource() async {
    final newMap = <String, dynamic>{};

    if (categoriesCache.isNotEmpty) {
      categoriesCache.forEach((key, value) {
        newMap[key] = value.toJson();
      });
    }
    
    return newMap;
  }

  /// Adds the given [Category] to the repository.
  Future<String> addProduct(Category category) async {
    final id = const Uuid().v4();
    final newCategory = category.copyWith(id: id);
    categoriesCache[id] = newCategory;
    
    return id;
  }

  /// Deletes [Category] from the repository by [id].
  Future<void> deleteProduct(String id) async {
    categoriesCache.remove(id);
  }

  /// Updates [Category] from the repository by [id].
  Future<void> updateProduct(String id, Category category) async {
    final toBeUpdated = categoriesCache[id];
    
    if (toBeUpdated == null) {
      return Future.error(Exception('Category not found'));
    }
  }
}
