import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firestore/firestore.dart';

Handler middleware(Handler handler) {
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
