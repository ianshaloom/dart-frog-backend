import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllTokens(context);
    case HttpMethod.post:
      return _postTokens(context);
    case HttpMethod.delete:
    case HttpMethod.put:
    case HttpMethod.patch:
    case HttpMethod.head:
    case HttpMethod.options:
      return Future.value(Response(statusCode: HttpStatus.methodNotAllowed));
  }
}

Future<Response> _getAllTokens(RequestContext context) async {
  final repo = context.read<DatasourceRepo>().tokensRepo;

  try { 

    final products = await repo.allTokens();
    return Response.json(body: products);
   } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _postTokens(RequestContext context) async {
  final repo = await context.read<DatasourceRepo>().tokensRepo;
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    final id = await repo.addToken(body);

    return Response(body: 'Product added with ID:$id', statusCode: HttpStatus.created);
  } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}
