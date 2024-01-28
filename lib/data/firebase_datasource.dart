import 'package:dart_frog_backend/constants/constants.dart';
import 'package:dart_frog_backend/repo.dart';
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
      final id = data['id'] as String? ?? const Uuid().v4();
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
}
