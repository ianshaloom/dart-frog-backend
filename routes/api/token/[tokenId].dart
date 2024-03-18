import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String productId,
) async{
  switch (context.request.method) {
    case HttpMethod.patch:
      return _updateToken(context, productId);
    case HttpMethod.delete:
      return _deleteToken(context, productId);
    case HttpMethod.get:
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _updateToken(RequestContext context, String tokenId) async {
  final repo = await context.read<DatasourceRepo>().tokensRepo;
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    await repo.updateToken(tokenId, body);
    return Response(body: 'Product updated');
   } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _deleteToken(RequestContext context, String tokenId) async {
  final repo = await context.read<DatasourceRepo>().tokensRepo;

  try {
    await repo.deleteToken(tokenId);
    return Response(body: 'Product deleted');
  } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}
