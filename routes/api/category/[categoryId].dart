import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String categoryId,
) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getCategory(context, categoryId);
    case HttpMethod.patch:
      return _updateCategory(context, categoryId);
    case HttpMethod.delete:
      return _deleteCategory(context, categoryId);
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.head:
    case HttpMethod.options:
      return Future.value(Response(statusCode: HttpStatus.methodNotAllowed));
  }
}

Future<Response> _getCategory(
  RequestContext context,
  String categoryId,
) async {
  final repo = await context.read<DatasourceRepo>().categoryRepo;

  try {
    final category = await repo.getItem(categoryId);
    return Response.json(body: category);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _updateCategory(
  RequestContext context,
  String categoryId,
) async {
  final repo = await context.read<DatasourceRepo>().categoryRepo;
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    await repo.updateItem(categoryId, body);
    return Response(body: 'Category updated');
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _deleteCategory(
  RequestContext context,
  String categoryId,
) async {
  final repo = await context.read<DatasourceRepo>().categoryRepo;

  try {
    await repo.deleteItem(categoryId);
    return Response(body: 'Category deleted');
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}
