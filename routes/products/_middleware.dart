import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/data/firebase_datasource.dart';
import 'package:dart_frog_backend/repo.dart';
import 'package:firedart/firestore/firestore.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
    provider<DatasourceRepo>((_) {

      print('===============>   ${Firestore.initialized}');

      return DatasourceRepo(FirebaseDatasource(Firestore.instance));
    }),
  );
}
