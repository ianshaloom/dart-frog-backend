import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/data/firebase_datasource.dart';
import 'package:dart_frog_backend/models/product/product.dart';
import 'package:dart_frog_backend/repo.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:uuid/uuid.dart';

Future<Response> onRequest(RequestContext context) {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getAll(context);
    case HttpMethod.post:
      return _postItem(context);
    case HttpMethod.put:
    case HttpMethod.delete:
    case HttpMethod.patch:
    case HttpMethod.head:
    case HttpMethod.options:
      return Future.value(Response(statusCode: HttpStatus.methodNotAllowed));
  }
}

Future<Response> _getAll(RequestContext context) async {
  final repo = context.read<DatasourceRepo>();

  try {
    final products = await repo.allProducts();
    for (final element in products) {
      print(element.name);
    }
    return Response();
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _postItem(RequestContext context) async {
  final repo = context.read<DatasourceRepo>();

  try {
    final id = await repo.addProduct(product);
    return Response(body: id);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Product product = Product(
  id: Uuid().v4(),
  name: 'Iphone 13 ProMax',
  price: 250000,
  description: 'Silver Blue',
  unitOfMeasurement: 'Piece',
  imageUrl: 'https://picsum.photos/250?image=9',
  categoryId: '5601ea90-17c7-4522-82f1-fc2389906a39',
);

// final DatasourceRepo repo =
//     DatasourceRepo(FirebaseDatasource(Firestore.instance));
