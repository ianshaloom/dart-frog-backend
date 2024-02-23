import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(RequestContext context, String discountId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getDiscount(context, discountId);
    case HttpMethod.patch:
      return _updateDiscount(context, discountId);
    case HttpMethod.delete:
      return _deleteDiscount(context, discountId);
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getDiscount(RequestContext context, String discountId) async {
  final repo = await context.read<DatasourceRepo>().discountRepo;

  try {
    final discount = await repo.getItem(discountId);

    return Response.json(body: discount);
  } on Exception catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _updateDiscount(
    RequestContext context, String discountId) async {
  final repo = await context.read<DatasourceRepo>().discountRepo;
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    await repo.updateItem(discountId, body);

    return Response(body: 'Discount updated');
   } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _deleteDiscount(
    RequestContext context, String discountId) async {
  final repo = await context.read<DatasourceRepo>().discountRepo;

  try {
    await repo.deleteItem(discountId);

    return Response(body: 'Discount deleted');
   } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}
