import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/cache/cache.dart';
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
   final cacheDep = context.read<CachingDependency>();

  try {
    final cache = await cacheDep.get(collection);

    if (cache != null) {
      return Response.json(body: cache);
    }

    final transactions = await repo.allTransaction(collection);
    cacheDep.set(collection, transactions, 60);

    return Response.json(body: transactions);
   } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _postItem(RequestContext context) async {
  final repo = await context.read<DatasourceRepo>().transactionRepo;
  final body = await context.request.json() as Map<String, dynamic>;
  final collection = await context.request.headers['collection']!;

  try {
    final id = await repo.addTransaction(body, collection);
    return Response(body: id);
   } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _deleteAll(RequestContext context) async {
  final repo = await context.read<DatasourceRepo>().transactionRepo;
  final collection = await context.request.headers['collection']!;

  try {
    await repo.deleteAllTransaction(collection);
    return Response(
        statusCode: HttpStatus.noContent, body: '$collection deleted');
  } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}
