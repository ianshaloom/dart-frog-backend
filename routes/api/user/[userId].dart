import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(RequestContext context, String userId) async{
  switch (context.request.method) {
    case HttpMethod.get:
      return _getUser(context, userId);
    case HttpMethod.patch:
      return _updateUser(context, userId);
    case HttpMethod.delete:
      return _deleteUser(context, userId);
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getUser(RequestContext context, String userId) async {
  final repo = await context.read<DatasourceRepo>().usersRepo;

  try {
    final user = await repo.getItem(userId);

    return Response.json(body: user);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _updateUser(RequestContext context, String userId) async {
  final repo = await context.read<DatasourceRepo>().usersRepo;
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    await repo.updateItem(userId, body);
    return Response(body: 'User details updated', statusCode: HttpStatus.noContent);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _deleteUser(RequestContext context, String userId) async {
  final repo = await context.read<DatasourceRepo>().usersRepo;

  try {
    await repo.deleteItem(userId);
    return Response(body: 'User deleted', statusCode: HttpStatus.noContent);
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}
