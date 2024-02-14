import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(RequestContext context) async{
  switch (context.request.method) {
    case HttpMethod.get:
      return _getAll(context);
    case HttpMethod.post:
      return _postItem(context);
    case HttpMethod.delete:
      return _deleteAll(context);
    case HttpMethod.put:
    case HttpMethod.patch:
    case HttpMethod.head:
    case HttpMethod.options:
      return Future.value(Response(statusCode: HttpStatus.methodNotAllowed));
  }
}

Future<Response> _getAll(RequestContext context) async {
  final repo = context.read<DatasourceRepo>().productRepo;

  try {
    final products = await repo.allItems();

    return Response.json(body: products);
  } on Exception catch (e) {
    return Response(statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _postItem(RequestContext context) async {
  final repo = await context.read<DatasourceRepo>().productRepo;
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    final id = await repo.addItem(body);
    return Response(body: id);
  } on Exception catch (e) {
    return Response(statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _deleteAll(RequestContext context) async {
  final repo = await context.read<DatasourceRepo>().productRepo;

  try {
    await repo.deleteAllItems();

    return Response(
        body: 'All products deleted', statusCode: HttpStatus.noContent);
  } on Exception catch (e) {
    return Response(statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}
