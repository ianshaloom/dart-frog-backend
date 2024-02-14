import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(RequestContext context) async {
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
  final repo = await context.read<DatasourceRepo>().transactionRepo;
  final collection = await context.request.headers['collection']!;

  try {
    final transactions = await repo.allTransaction(collection);

    return Response.json(body: transactions);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _postItem(RequestContext context) async {
  final repo = await context.read<DatasourceRepo>().transactionRepo;
  final body = await context.request.json() as Map<String, dynamic>;
  final collection = await context.request.headers['collection']!;

  try {
    final id = await repo.addTransaction(body, collection);
    return Response(body: id);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _deleteAll(RequestContext context) async {
  final repo = await context.read<DatasourceRepo>().transactionRepo;
  final collection = await context.request.headers['collection']!;

  try {
    await repo.deleteAllTransaction(collection);
    return Response(
        statusCode: HttpStatus.noContent, body: '$collection deleted');
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}
