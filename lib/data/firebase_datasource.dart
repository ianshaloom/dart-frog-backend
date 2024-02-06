import 'package:dart_frog_backend/constants/constants.dart';
import 'package:dart_frog_backend/repo.dart';
import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:uuid/uuid.dart';

/// Firebase Datasource
class FirebaseDatasource extends DatabaseRepo {
  /// Firebase Datasource Constructor
  FirebaseDatasource(this.firestore);

  /// Firestore instance
  final Firestore firestore;

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
  Future<String> addProduct(Map<String, dynamic> data) async {

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
  Future<String> addSubCategory(Map<String, dynamic> data) async {
    try {
      final id = data['id'] as String? ?? const Uuid().v4();
      data['id'] = id;

      // Replace "collectionName" and "documentId" with your actual values
      final collection = firestore.collection(categoriesCollection);
      final documentRef = collection.document('1cGvDo6LNfW9l0zEiADT');
      final subcollectionRef = documentRef.collection(subCategoriesCollection);

      final subcollectionData = <String, dynamic>{
        'name': 'slippers',
      };

      final doc = await subcollectionRef.document(id).create(subcollectionData);

      return doc.id;
    } on Exception catch (_) {
      return Future.error(Exception('Error adding subcategory'));
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
  Future<Map<String, dynamic>> allSubCategories(String categoryId) async {
    final mapOfSubCategories = <String, dynamic>{};

    try {
      final collection = firestore.collection(categoriesCollection);
      final documentRef = collection.document(categoryId);
      final subcollectionRef = documentRef.collection(subCategoriesCollection);

      await subcollectionRef.get().then((value) {
        for (final doc in value) {
          mapOfSubCategories[doc.id] = doc.map;
        }
      });

      return mapOfSubCategories;
    } on Exception catch (_) {
      return Future.error(Exception('Error fetching subcategories'));
    }
  }
}
