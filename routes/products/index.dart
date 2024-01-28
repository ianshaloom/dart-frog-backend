import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repo.dart';

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
  final listOfValues = <Map<String, dynamic>>[];

  try {
    final products = await repo.allProducts();

    for (final product in products) {
      final productMap = product.toJson();
      listOfValues.add(productMap);
    }

    return Response.json(body: listOfValues);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _postItem(RequestContext context) async {
  final repo = context.read<DatasourceRepo>();
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    final id = await repo.addProduct(body);
    return Response(body: id);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}
