import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/cache/cache.dart';
import 'package:dart_frog_backend/constants/constants.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getDiscount(context);
    case HttpMethod.post:
      return _postDiscount(context);
    case HttpMethod.delete:
      return _deleteAllDiscounts(context);
    case HttpMethod.patch:
    case HttpMethod.put:
    case HttpMethod.head:
    case HttpMethod.options:
      return Future.value(Response(statusCode: HttpStatus.methodNotAllowed));
  }
}

FutureOr<Response> _getDiscount(RequestContext context) async {
  final repo = await context.read<DatasourceRepo>().discountRepo;
   final cacheDep = context.read<CachingDependency>();

  try {
    final cache = await cacheDep.get(discountsCollection);

    if (cache != null) {
      return Response.json(body: cache);
    }

    final discounts = await repo.allItems();
    cacheDep.set(discountsCollection, discounts, 60);
    
    return Response.json(body: discounts);
   } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _postDiscount(RequestContext context) async {
  final repo = await context.read<DatasourceRepo>().discountRepo;
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    final id = await repo.addItem(body);
    return Response(body: id);
   } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _deleteAllDiscounts(RequestContext context) async {
  final repo = await context.read<DatasourceRepo>().discountRepo;

  try {
    await repo.deleteAllItem();

    return Response(body: 'All Discounts deleted');
  } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}
