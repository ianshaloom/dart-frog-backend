import 'package:dart_frog_backend/data/datasource.dart';
import 'package:dart_frog_backend/repository/repo.dart';

class DatasourceRepo {
  DatasourceRepo(this.databaseRepo);

  final DatabaseRepo databaseRepo;

  ProductRepoImpl get productRepo => ProductRepoImpl(databaseRepo);

  CategoryRepoImpl get categoryRepo => CategoryRepoImpl(databaseRepo);

  UsersRepoImpl get usersRepo => UsersRepoImpl(databaseRepo);

  DiscountRepoImpl get discountRepo => DiscountRepoImpl(databaseRepo);

  ExpenseRepoImpl get expenseRepo => ExpenseRepoImpl(databaseRepo);

  TransactionRepoImpl get transactionRepo => TransactionRepoImpl(databaseRepo);
}

class ProductRepoImpl extends ModelRepo {
  ProductRepoImpl(this.databaseRepo);

  final DatabaseRepo databaseRepo;

  @override
  Future<Map<String, dynamic>> getItem(String id) async {
    final product = await databaseRepo.getProduct(id);
    return product;
  }

  @override
  Future<String> addItem(Map<String, dynamic> data) async {
    final id = await databaseRepo.addProducts(data);
    return id;
  }

  @override
  Future<void> updateItem(String id, Map<String, dynamic> data) async {
    await databaseRepo.updateProduct(id, data);
  }

  @override
  Future<void> deleteItem(String id) async {
    await databaseRepo.deleteProduct(id);
  }

  @override
  Future<List<Map<String, dynamic>>> allItems() async {
    final listOfProducts = await databaseRepo.allProducts();

    return listOfProducts;
  }

  Future<void> deleteAllItems() async {
    await databaseRepo.deleteAllProducts();
  }
}

class CategoryRepoImpl extends ModelRepo {
  CategoryRepoImpl(this.databaseRepo);

  final DatabaseRepo databaseRepo;

  @override
  Future<Map<String, dynamic>> getItem(String id) async {
    final category = await databaseRepo.getCategory(id);
    return category;
  }

  @override
  Future<String> addItem(Map<String, dynamic> data) async {
    final id = await databaseRepo.addCategory(data);
    return id;
  }

  @override
  Future<void> updateItem(String id, Map<String, dynamic> data) async {
    await databaseRepo.updateCategory(id, data);
  }

  @override
  Future<void> deleteItem(String id) async {
    await databaseRepo.deleteCategory(id);
  }

  Future<void> deleteAllItems() async {
    await databaseRepo.deleteAllCategories();
  }

  @override
  Future<List<Map<String, dynamic>>> allItems() async {
    final categories = await databaseRepo.allCategories();
    return categories;
  }
}

class UsersRepoImpl extends ModelRepo {
  UsersRepoImpl(this.databaseRepo);

  final DatabaseRepo databaseRepo;

  @override
  Future<Map<String, dynamic>> getItem(String id) async {
    final user = await databaseRepo.getUser(id);
    return user;
  }

  @override
  Future<String> addItem(Map<String, dynamic> data) async {
    final id = await databaseRepo.addUser(data);
    return id;
  }

  @override
  Future<void> updateItem(String id, Map<String, dynamic> data) async {
    await databaseRepo.updateUser(id, data);
  }

  @override
  Future<void> deleteItem(String id) async {
    await databaseRepo.deleteUser(id);
  }

  @override
  Future<List<Map<String, dynamic>>> allItems() async {
    final users = await databaseRepo.allUsers();
    return users;
  }

  Future<void> deleteAllItems() async {
    await databaseRepo.deleteAllUsers();
  }
}

class DiscountRepoImpl extends ModelRepo {
  DiscountRepoImpl(this.databaseRepo);

  final DatabaseRepo databaseRepo;

  @override
  Future<Map<String, dynamic>> getItem(String id) async {
    final discount = await databaseRepo.getDiscount(id);
    return discount;
  }

  @override
  Future<String> addItem(Map<String, dynamic> data) async {
    final id = await databaseRepo.addDiscount(data);
    return id;
  }

  @override
  Future<void> updateItem(String id, Map<String, dynamic> data) async {
    await databaseRepo.updateDiscount(id, data);
  }

  @override
  Future<void> deleteItem(String id) async {
    await databaseRepo.deleteDiscount(id);
  }

  @override
  Future<List<Map<String, dynamic>>> allItems() async {
    final discounts = await databaseRepo.allDiscounts();
    return discounts;
  }

  Future<void> deleteAllItem() async {
    await databaseRepo.deleteAllDiscounts();
  }
}

class ExpenseRepoImpl extends ModelRepo {
  ExpenseRepoImpl(this.databaseRepo);

  final DatabaseRepo databaseRepo;

  @override
  Future<Map<String, dynamic>> getItem(String id) async {
    final expense = await databaseRepo.getExpense(id);
    return expense;
  }

  @override
  Future<String> addItem(Map<String, dynamic> data) async {
    final id = await databaseRepo.addExpense(data);
    return id;
  }

  @override
  Future<void> updateItem(String id, Map<String, dynamic> data) async {
    await databaseRepo.updateExpense(id, data);
  }

  @override
  Future<void> deleteItem(String id) async {
    await databaseRepo.deleteExpense(id);
  }

  @override
  Future<List<Map<String, dynamic>>> allItems() async {
    final expenses = await databaseRepo.allExpenses();
    return expenses;
  }

  Future<void> deleteAllItem() async {
    await databaseRepo.deleteAllExpenses();
  }
}

class TransactionRepoImpl {
  TransactionRepoImpl(this.databaseRepo);

  final DatabaseRepo databaseRepo;

  Future<Map<String, dynamic>> getTransaction(
      String id, String collection) async {
    final transaction = await databaseRepo.getTransaction(id, collection);
    return transaction;
  }

  Future<String> addTransaction(
      Map<String, dynamic> data, String collection) async {
    final id = await databaseRepo.addTransaction(data, collection);
    return id;
  }

  Future<void> updateTransaction(
      String id, Map<String, dynamic> data, String collection) async {
    await databaseRepo.updateTransaction(id, data, collection);
  }

  Future<void> deleteTransaction(String id, String collection) async {
    await databaseRepo.deleteTransaction(id, collection);
  }

  Future<List<Map<String, dynamic>>> allTransaction(
      String collection) async {
    final transactions = await databaseRepo.allTransactions(collection);
    return transactions;
  }

  Future<void> deleteAllTransaction(String collection) async {
    await databaseRepo.deleteAllTransactions(collection);
  }
}
