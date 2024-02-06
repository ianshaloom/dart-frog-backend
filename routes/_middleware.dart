import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/data/firebase_datasource.dart';
import 'package:dart_frog_backend/repo.dart';
import 'package:firedart/firestore/firestore.dart';

Handler middleware(Handler handler) {
  final h = handler.use(requestLogger()).use(
    provider<DatasourceRepo>((_) {
      return DatasourceRepo(FirebaseDatasource(Firestore.instance));
    }),
  ).use(
    firebaseMiddleware,
  );

  return h;
}

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
