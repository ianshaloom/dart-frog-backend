import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/data/firebase_datasource.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';
import 'package:dart_frog_backend/repository/session/session.dart';
import 'package:dart_frog_backend/repository/user/user.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:dart_frog_backend/cache/cache.dart';

Handler middleware(Handler handler) {
  final h = handler
      .use(requestLogger())
      .use(userMiddleware)
      .use(
        provider<DatasourceRepo>((_) {
          return DatasourceRepo(FireStoreImpl(Firestore.instance));
        }),
      )
      .use(firebaseMiddleware)
      .use(internalCacheMiddleware)
      .use(sessionMiddleware);

  return h;
}

String? value = Platform.environment['FIREBASE_PROJECT_ID'];
Handler firebaseMiddleware(Handler handler) {
  return (RequestContext context) async {
    try {
      if (!Firestore.initialized) {
        Firestore.initialize('digi-duka');
      }

      final response = await handler(context);
      return response;
    } on Exception catch (_) {
      return Response(statusCode: HttpStatus.internalServerError);
    }
  };
}

Handler internalCacheMiddleware(Handler handler) {
  return (RequestContext context) async {
    Response response;

    try {
      final internalCache = CachingDependency();

      response = await handler
          .use(provider<CachingDependency>((_) => internalCache))
          .call(context);
    } catch (e) {
      response = Response(
        statusCode: HttpStatus.internalServerError,
        body: 'outer try ${e.toString()}',
      );
    }

    return response;
  };
}

Handler sessionMiddleware(Handler handler) {
  return (RequestContext context) async {
    Response response;

    try {
      final sessionRepo = SessionRepository();

      response = await handler
          .use(provider<SessionRepository>((_) => sessionRepo))
          .call(context);
    } catch (e) {
      response = Response(
        statusCode: HttpStatus.internalServerError,
        body: 'outer try ${e.toString()}',
      );
    }

    return response;
  };
}

Handler userMiddleware(Handler handler) {
  return (RequestContext context) async {
    Response response;
    final datarepo = context.read<DatasourceRepo>();

    try {
      final userRepo = UserRepository(datarepo);

      response = await handler
          .use(provider<UserRepository>((_) => userRepo))
          .call(context);
    } catch (e) {
      response = Response(
        statusCode: HttpStatus.internalServerError,
        body: 'outer try ${e.toString()}',
      );
    }

    return response;
  };
}
