import 'package:dart_frog_backend/constants/constants.dart';
import 'package:dart_frog_backend/data/datasource.dart';
import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:uuid/uuid.dart';

/// Firebase Datasource
class FireStoreImpl extends DatabaseRepo {
  FireStoreImpl(this.firestore);

  final Firestore firestore;

  /* --------------------------------[PRODUCT]----------------------------------- */

  @override
  Future<Map<String, dynamic>> getProduct(String id) async {
    try {
      final doc =
          await firestore.collection(productsCollection).document(id).get();
      return doc.map;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching product'));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> allProducts() async {
    final listOfProducts = <Map<String, dynamic>>[];

    try {
      await firestore.collection(productsCollection).get().then((value) {
        for (final doc in value) {
          listOfProducts.add(doc.map);
        }
      });

      return listOfProducts;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching products'));
    }
  }

  @override
  Future<String> addProducts(Map<String, dynamic> data) async {
    try {
      final id = const Uuid().v4();
      data['id'] = id;

      final doc = await firestore
          .collection(productsCollection)
          .document(id)
          .create(data);
      return doc.id;
    } on Exception catch (_) {
      return Future.error(Exception('Error adding product'));
    }
  }

  @override
  Future<void> updateProduct(String id, Map<String, dynamic> data) async {
    try {
      await firestore.collection(productsCollection).document(id).update(data);
    } on Exception catch (_) {
      return Future.error(Exception('Error updating product'));
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await firestore.collection(productsCollection).document(id).delete();
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting product'));
    }
  }

  @override
  Future<void> deleteAllProducts() async {
    try {
      await firestore.collection(productsCollection).get().then((value) async {
        for (final doc in value) {
          await doc.reference.delete();
        }
      });
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting all products'));
    }
  }

  /* --------------------------------[CATEGORY]----------------------------------- */
  @override
  Future<Map<String, dynamic>> getCategory(String id) async {
    try {
      final doc =
          await firestore.collection(categoriesCollection).document(id).get();
      return doc.map;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching category'));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> allCategories() async {
    final listOfCategories = <Map<String, dynamic>>[];

    try {
      await firestore.collection(categoriesCollection).get().then((value) {
        for (final doc in value) {
          listOfCategories.add(doc.map);
        }
      });

      return listOfCategories;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching categories'));
    }
  }

  @override
  Future<String> addCategory(Map<String, dynamic> data) async {
    try {
      final id = data['id'] as String? ?? const Uuid().v4();
      data['id'] = id;

      final doc = await firestore
          .collection(categoriesCollection)
          .document(id)
          .create(data);
      return doc.id;
    } on Exception catch (_) {
      return Future.error(Exception('Error adding category'));
    }
  }

  @override
  Future<void> updateCategory(String id, Map<String, dynamic> data) async {
    try {
      await firestore
          .collection(categoriesCollection)
          .document(id)
          .update(data);
    } on Exception catch (_) {
      return Future.error(Exception('Error updating category'));
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await firestore.collection(categoriesCollection).document(id).delete();
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting category'));
    }
  }

  @override
  Future<void> deleteAllCategories() async {
    try {
      await firestore
          .collection(categoriesCollection)
          .get()
          .then((value) async {
        for (final doc in value) {
          await doc.reference.delete();
        }
      });
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting all categories'));
    }
  }

  /* --------------------------------[USER]----------------------------------- */
  @override
  Future<Map<String, dynamic>> getUser(String id) async {
    try {
      final doc =
          await firestore.collection(usersCollection).document(id).get();
      return doc.map;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching user'));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> allUsers() async {
    final listOfUsers = <Map<String, dynamic>>[];

    try {
      await firestore.collection(usersCollection).get().then((value) {
        for (final doc in value) {
          listOfUsers.add(doc.map);
        }
      });

      return listOfUsers;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching users'));
    }
  }

  @override
  Future<String> addUser(Map<String, dynamic> data) async {
    try {
      final id = data['id'] as String? ?? const Uuid().v4();

      final userExist = await userExists(id);

      if (userExist) {
        return 'User already exists';
      }

      final doc =
          await firestore.collection(usersCollection).document(id).create(data);
      return doc.id;
    } on Exception catch (_) {
      return Future.error(Exception('Error adding user'));
    }
  }

  @override
  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    try {
      await firestore.collection(usersCollection).document(id).update(data);
    } on Exception catch (_) {
      return Future.error(Exception('Error updating user'));
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await firestore.collection(usersCollection).document(id).delete();
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting user'));
    }
  }

  @override
  Future<void> deleteAllUsers() async {
    try {
      await firestore.collection(usersCollection).get().then((value) async {
        for (final doc in value) {
          await doc.reference.delete();
        }
      });
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting all users'));
    }
  }

  @override
  Future<bool> userExists(String id) async {
    try {
      final doc =
          await firestore.collection(usersCollection).document(id).exists;
      return doc;
    } catch (e) {
      return Future.error(e);
    }
  }

  /* --------------------------------[DISCOUNT]----------------------------------- */
  @override
  Future<Map<String, dynamic>> getDiscount(String id) async {
    try {
      final doc =
          await firestore.collection(discountsCollection).document(id).get();
      return doc.map;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching discount'));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> allDiscounts() async {
    final listOfDiscounts = <Map<String, dynamic>>[];

    try {
      await firestore.collection(discountsCollection).get().then((value) {
        for (final doc in value) {
          listOfDiscounts.add(doc.map);
        }
      });

      return listOfDiscounts;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching discounts'));
    }
  }

  @override
  Future<String> addDiscount(Map<String, dynamic> data) async {
    try {
      final id = const Uuid().v4();
      data['id'] = id;

      final doc = await firestore
          .collection(discountsCollection)
          .document(id)
          .create(data);
      return doc.id;
    } on Exception catch (_) {
      return Future.error(Exception('Error adding discount'));
    }
  }

  @override
  Future<void> updateDiscount(String id, Map<String, dynamic> data) async {
    try {
      await firestore.collection(discountsCollection).document(id).update(data);
    } on Exception catch (_) {
      return Future.error(Exception('Error updating discount'));
    }
  }

  @override
  Future<void> deleteDiscount(String id) async {
    try {
      await firestore.collection(discountsCollection).document(id).delete();
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting discount'));
    }
  }

  @override
  Future<void> deleteAllDiscounts() async {
    try {
      await firestore.collection(discountsCollection).get().then((value) async {
        for (final doc in value) {
          await doc.reference.delete();
        }
      });
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting all discounts'));
    }
  }

  /* --------------------------------[TRANSACTION]----------------------------------- */
  @override
  Future<Map<String, dynamic>> getTransaction(
      String id, String collection) async {
    try {
      final doc = await firestore.collection(collection).document(id).get();
      return doc.map;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching transaction'));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> allTransactions(String collection) async {
    final listOfTransactions = <Map<String, dynamic>>[];

    try {
      await firestore.collection(collection).get().then((value) {
        for (final doc in value) {
          listOfTransactions.add(doc.map);
        }
      });

      return listOfTransactions;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching transactions'));
    }
  }

  @override
  Future<String> addTransaction(
      Map<String, dynamic> data, String collection) async {
    try {
      final id = const Uuid().v4();
      data['id'] = id;

      final doc =
          await firestore.collection(collection).document(id).create(data);
      return doc.id;
    } on Exception catch (_) {
      return Future.error(Exception('Error adding transaction'));
    }
  }

  @override
  Future<void> updateTransaction(
      String id, Map<String, dynamic> data, String collection) async {
    try {
      await firestore.collection(collection).document(id).update(data);
    } on Exception catch (_) {
      return Future.error(Exception('Error updating transaction'));
    }
  }

  @override
  Future<void> deleteTransaction(String id, String collection) async {
    try {
      await firestore.collection(collection).document(id).delete();
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting transaction'));
    }
  }

  @override
  Future<void> deleteAllTransactions(String collection) async {
    try {
      await firestore.collection(collection).get().then((value) async {
        for (final doc in value) {
          await doc.reference.delete();
        }
      });
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting all transactions'));
    }
  }

  /* --------------------------------[EXPENSE]----------------------------------- */
  @override
  Future<Map<String, dynamic>> getExpense(String id) async {
    try {
      final doc =
          await firestore.collection(expensesCollection).document(id).get();
      return doc.map;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching expense'));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> allExpenses() async {
    final listOfExpenses = <Map<String, dynamic>>[];

    try {
      await firestore.collection(expensesCollection).get().then((value) {
        for (final doc in value) {
          listOfExpenses.add(doc.map);
        }
      });

      return listOfExpenses;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching expenses'));
    }
  }

  @override
  Future<String> addExpense(Map<String, dynamic> data) async {
    try {
      final id = const Uuid().v4();
      data['id'] = id;

      final doc = await firestore
          .collection(expensesCollection)
          .document(id)
          .create(data);
      return doc.id;
    } on Exception catch (_) {
      return Future.error(Exception('Error adding expense'));
    }
  }

  @override
  Future<void> updateExpense(String id, Map<String, dynamic> data) async {
    try {
      await firestore.collection(expensesCollection).document(id).update(data);
    } on Exception catch (_) {
      return Future.error(Exception('Error updating expense'));
    }
  }

  @override
  Future<void> deleteExpense(String id) async {
    try {
      await firestore.collection(expensesCollection).document(id).delete();
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting expense'));
    }
  }

  @override
  Future<void> deleteAllExpenses() async {
    try {
      await firestore.collection(expensesCollection).get().then((value) async {
        for (final doc in value) {
          await doc.reference.delete();
        }
      });
    } on Exception catch (_) {
      return Future.error(Exception('Error deleting all expenses'));
    }
  }
}
