/// Model Datasource Interaction
abstract class ModelRepo {
  /// Fetch an [dynamic] by [id]
  Future<Map<String, dynamic>> getItem(String id);

  /// Adds the given [dynamic] to the repository.
  Future<String> addItem(Map<String, dynamic> data);

  /// Updates [dynamic] from the repository by [id].
  Future<void> updateItem(String id, Map<String, dynamic> data);

  /// Deletes [dynamic] from the repository by [id].
  Future<void> deleteItem(String id);

  /// Return a [dynamic] with the given id
  Future<List<Map<String, dynamic>>> allItems();
}
