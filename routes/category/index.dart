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

  // check if there is a header
  if (context.request.headers['categoryId'] != null) {
    final categoryId = context.request.headers['categoryId']!;

    try {
      final subCategories = await repo.allSubCategories(categoryId);

      return Response.json(body: subCategories);
    } on Exception catch (_) {
      return Response(statusCode: HttpStatus.internalServerError);
    }
  }

  try {
    final products = await repo.allCategories();
    return Response.json(body: products);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _postItem(RequestContext context) async {
  final repo = context.read<DatasourceRepo>();
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    final id = await repo.addCategory(body);
    return Response(body: id);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}
