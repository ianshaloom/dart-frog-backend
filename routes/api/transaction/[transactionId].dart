import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String transactionId,
) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getTransaction(context, transactionId);
    case HttpMethod.patch:
      return _updateTransaction(context, transactionId);
    case HttpMethod.delete:
      return _deleteTransaction(context, transactionId);
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getTransaction(
  RequestContext context,
  String transactionId,
) async {
  final repo = await context.read<DatasourceRepo>().transactionRepo;
  final collection = await context.request.headers['collection']!;

  try {
    final transaction =
        await repo.getTransaction(transactionId, collection);

    return Response.json(body: transaction);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _updateTransaction(
  RequestContext context,
  String transactionId,
) async {
  final repo = await context.read<DatasourceRepo>().transactionRepo;
  final body = await context.request.json() as Map<String, dynamic>;
  final collection = await context.request.headers['collection']!;

  try {
    await repo.updateTransaction(transactionId, body, collection);

    return Response(statusCode: HttpStatus.noContent, body: '$collection updated');

  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _deleteTransaction(
  RequestContext context,
  String transactionId,
) async {
  final repo = await context.read<DatasourceRepo>().transactionRepo;
  final collection = await context.request.headers['collection']!;

  try {
    await repo.deleteTransaction(transactionId, collection);

    return Response(statusCode: HttpStatus.noContent, body: '$collection deleted');
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}
