import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/session/session.dart';
import 'package:dart_frog_backend/repository/user/user.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => await _createUser(context),
    HttpMethod.get => await _authenticateUser(context),
    _ => Response(statusCode: HttpStatus.methodNotAllowed)
  };
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
  } on Exception catch (_) {
    return Response(statusCode: HttpStatus.internalServerError);
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

    if (user == null) {
      return Response(statusCode: HttpStatus.unauthorized, body: 'Account with $email not found.');
    }

    final session = await sessionRepo.createSession(user.id);

    return Response(body: session.token);
    
  }  catch (e) {
    return Response(statusCode: HttpStatus.internalServerError, body: 'Error: $e');
  }
}
