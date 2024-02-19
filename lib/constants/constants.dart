import 'dart:convert';

import 'package:crypto/crypto.dart';

/// A  collection of products.
const String productsCollection = 'products';
/// A collection of categories.
const String categoriesCollection = 'categories';
/// A collection of subcategories.
const String subCategoriesCollection = 'subcategories';

/// A collection of users.
const String usersCollection = 'users';

/// A collection of discounts.
const String discountsCollection = 'discounts';

/// A collection of transactions.
const String ordersCollection = 'orders';
const String salesCollection = 'sales';
const String purchasesCollection = 'purchases';


/// A collection of expenses.
const String expensesCollection = 'expenses';

extension StringExtension on String {
  String hashWithSHA256() {
    var bytes = utf8.encode(this);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
