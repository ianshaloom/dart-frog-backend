import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String productId,
) async{
  switch (context.request.method) {
    case HttpMethod.get:
      return _getProduct(context, productId);
    case HttpMethod.patch:
      return _updateProduct(context, productId);
    case HttpMethod.delete:
      return _deleteProduct(context, productId);
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getProduct(RequestContext context, String productId) async {
  final repo = await context.read<DatasourceRepo>().productRepo;

  try {
    final product = await repo.getItem(productId);
    return Response.json(body: product);
  } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _updateProduct(RequestContext context, String productId) async {
  final repo = await context.read<DatasourceRepo>().productRepo;
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    await repo.updateItem(productId, body);
    return Response(body: 'Product updated');
   } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _deleteProduct(RequestContext context, String productId) async {
  final repo = await context.read<DatasourceRepo>().productRepo;

  try {
    await repo.deleteItem(productId);
    return Response(body: 'Product deleted');
  } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}
