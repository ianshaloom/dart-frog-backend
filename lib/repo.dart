import 'package:dart_frog_backend/models/products/product.dart';

/// database repo
class DatasourceRepo {
  /// Creates a [DatasourceRepo] that uses the given [DatabaseRepo].
  DatasourceRepo(this.databaseRepo);

  /// A [DatabaseRepo] is a repository
  final DatabaseRepo databaseRepo;

  /// Return a all [Product] from data source.
  Future<List<Product>> allProducts() async {
    final products = <Product>[];

    final listOfProducts = await databaseRepo.allProducts();

    for (final product in listOfProducts) {
      products.add(Product.fromJson(product));
    }
    return products;
  }

  /// Adds the given Product to the repository.
  Future<String> addProduct(Map<String, dynamic> json) async {
    final id = await databaseRepo.addProduct(json);
    return id;
  }

  /// Add the given Category to the repository.
  Future<String> addCategory(Map<String, dynamic> json) async {
    final id = await databaseRepo.addCategory(json);
    return id;
  }

  /// Add the given SubCategory to the repository.
  Future<String> addSubCategory(Map<String, dynamic> json) async {
    final id = await databaseRepo.addSubCategory(json);
    return id;
  }

  /// Return a all Category from data source.
  Future<List<Map<String, dynamic>>> allCategories() async {
    final categories = await databaseRepo.allCategories();
    return categories;
  }

  /// Return a all SubCategory from data source.
  Future<Map<String, dynamic>> allSubCategories(String categoryId) async {
    final subCategories = await databaseRepo.allSubCategories(categoryId);
    return subCategories;
  }
}

/// A [DatabaseRepo] is a repository
abstract class DatabaseRepo {
  /// Return a [dynamic] with the given id
  Future<List<Map<String, dynamic>>> allProducts();

  /// Adds the given [dynamic] to the repository.
  Future<String> addProduct(Map<String, dynamic> data);
  /*  /// Deletes [dynamic] from the repository by [id].
  Future<void> delete(String id);
  /// Updates [dynamic] from the repository by [id].
  Future<void> update(String id, dynamic data); */

  /// adds the given category to the repository.
  Future<String> addCategory(Map<String, dynamic> data);

  /// Add a subcategory to the to a category.
  Future<String> addSubCategory(Map<String, dynamic> data);

  /// Return a all [dynamic] from data source.
  Future<List<Map<String, dynamic>>> allCategories();

  /// Return a all [dynamic] from data source.
  Future<Map<String, dynamic>> allSubCategories(String categoryId);
}
