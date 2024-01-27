import 'package:dart_frog_backend/models/product/product.dart';

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

  /// Adds the given [Product] to the repository.
  Future<String> addProduct(Product product) async {
    final id = await databaseRepo.addProduct(product.toJson());
    return id;
  }

  /// factory constructor

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
}
