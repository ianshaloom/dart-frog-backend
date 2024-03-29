import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/session/session.dart';
import 'package:dart_frog_backend/repository/user/user.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _authenticateUser(context);
    case HttpMethod.post:
      return _createUser(context);
    case HttpMethod.delete:
    case HttpMethod.put:
    case HttpMethod.patch:
    case HttpMethod.head:
    case HttpMethod.options:
      return Future.value(Response(statusCode: HttpStatus.methodNotAllowed));
  }
/*   return switch (context.request.method) {
    HttpMethod.post => await _createUser(context),
    HttpMethod.get => await _authenticateUser(context),
    _ => Response(statusCode: HttpStatus.methodNotAllowed)
  }; */
}

Future<Response> _createUser(RequestContext context) async {
  final userRepo = await context.read<UserRepository>();
  final body = await context.request.json() as Map<String, dynamic>;

  final username = body['username'] as String?;
  final email = body['email'] as String?;
  final password = body['password'] as String?;

  try {
    if (username == null || email == null || password == null) {
      return Response(statusCode: HttpStatus.badRequest);
    }

    final user = await userRepo.createUser(username, email, password);
    return Response(body: user);
  } catch (e) {
    return Response(statusCode: HttpStatus.internalServerError, body: 'Error: $e');
  }
}

Future<Response> _authenticateUser(RequestContext context) async {
  final userRepo = await context.read<UserRepository>();
  final sessionRepo = await context.read<SessionRepository>();

  final body = await context.request.json() as Map<String, dynamic>;

  final email = body['email'] as String?;
  final password = body['password'] as String?;

  try {
    if (email == null || password == null) {
      return Response(statusCode: HttpStatus.badRequest);
    }

    final user = await userRepo.userFromCredentials(email, password);

    if (!user.exists) {
      return Response(statusCode: HttpStatus.unauthorized, body: 'Account with $email not found.');
    }

    if (!user.isAuth) {
      return Response(statusCode: HttpStatus.unauthorized, body: 'Invalid password.');
    }

    final session = await sessionRepo.createSession(user.user!.id);

    return Response(body: session.token);
    
  }  catch (e) {
    return Response(statusCode: HttpStatus.internalServerError, body: 'Error: $e');
  }
}
