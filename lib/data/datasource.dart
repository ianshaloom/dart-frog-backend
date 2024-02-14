/// A [DatabaseRepo] is a repository
abstract class DatabaseRepo {
  /// Products CRUD operations
  Future<Map<String, dynamic>> getProduct(String id);
  Future<List<Map<String, dynamic>>> allProducts();
  Future<String> addProducts(Map<String, dynamic> data);
  Future<void> updateProduct(String id, Map<String, dynamic> data);
  Future<void> deleteProduct(String id);
  Future<void> deleteAllProducts();

  /// Category CRUD operations
  Future<Map<String, dynamic>> getCategory(String id);
  Future<List<Map<String, dynamic>>> allCategories();
  Future<String> addCategory(Map<String, dynamic> data);
  Future<void> updateCategory(String id, Map<String, dynamic> data);
  Future<void> deleteCategory(String id);
  Future<void> deleteAllCategories();

  /// User Crud operations
  Future<Map<String, dynamic>> getUser(String id);
  Future<List<Map<String, dynamic>>> allUsers();
  Future<String> addUser(Map<String, dynamic> data);
  Future<void> updateUser(String id, Map<String, dynamic> data);
  Future<void> deleteUser(String id);
  Future<void> deleteAllUsers();

  /// Discount CRUD operations
  Future<Map<String, dynamic>> getDiscount(String id);
  Future<List<Map<String, dynamic>>> allDiscounts();
  Future<String> addDiscount(Map<String, dynamic> data);
  Future<void> updateDiscount(String id, Map<String, dynamic> data);
  Future<void> deleteDiscount(String id);
  Future<void> deleteAllDiscounts();

  /// Transaction CRUD operations
  Future<Map<String, dynamic>> getTransaction(String id, String collectionName);
  Future<List<Map<String, dynamic>>> allTransactions(String collectionName);
  Future<String> addTransaction(
      Map<String, dynamic> data, String collectionName);
  Future<void> updateTransaction(
      String id, Map<String, dynamic> data, String collectionName);
  Future<void> deleteTransaction(String id, String collectionName);
  Future<void> deleteAllTransactions(String collectionName);

  /// expense CRUD operations
  Future<Map<String, dynamic>> getExpense(String id);
  Future<List<Map<String, dynamic>>> allExpenses();
  Future<String> addExpense(Map<String, dynamic> data);
  Future<void> updateExpense(String id, Map<String, dynamic> data);
  Future<void> deleteExpense(String id);
  Future<void> deleteAllExpenses();
}
