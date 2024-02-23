import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/user/user.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  switch (context.request.method) {
    case HttpMethod.patch:
      return _updateUser(context, id);
    case HttpMethod.delete:
      return _deleteUser(context, id);
    case HttpMethod.get:
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.head:
    case HttpMethod.options:
      return Future.value(Response(statusCode: HttpStatus.methodNotAllowed));
  }
}

Future<Response> _updateUser(RequestContext context, String id) async {
  final userRepo = await context.read<UserRepository>();
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    final user = await userRepo.userFromId(id);

    if (user == null) {
      return Response(statusCode: HttpStatus.notFound, body: 'User not found');
    }

    if (user.id != id) {
      return Response(statusCode: HttpStatus.forbidden);
    }

    final username = body['username'] as String? ?? user.username;
    final email = body['email'] as String? ?? user.email;
    final password = body['password'] as String? ?? user.password;

    final updatedUser = await userRepo.updateUser(id,
        username: username, email: email, password: password);

    return Response.json(body: updatedUser.toJson());
  } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: 'Error: $e');
  }
}

Future<Response> _deleteUser(RequestContext context, String id) async {
  final userRepo = await context.read<UserRepository>();

  try {
    final user = await userRepo.userFromId(id);

    if (user == null) {
      return Response(statusCode: HttpStatus.notFound, body: 'User not found');
    }

    if (user.id != id) {
      return Response(statusCode: HttpStatus.forbidden);
    }

    await userRepo.deleteUser(id);

    return Response(statusCode: HttpStatus.noContent, body: 'User deleted');
   } catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: 'Error: $e');
  }
}
