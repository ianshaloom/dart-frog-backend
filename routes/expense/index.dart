import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(RequestContext context) {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllExpenses(context);
    case HttpMethod.post:
      return _postExpense(context);
    case HttpMethod.delete:
     return _deleteAllExpenses(context);
    case HttpMethod.put:
    case HttpMethod.patch:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getAllExpenses(RequestContext context) async{
  final repo = await  context.read<DatasourceRepo>().expenseRepo;

  try {
    final expenses = await repo.allItems();

    return Response.json(body: expenses);
  } on Exception catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _postExpense(RequestContext context) async{
  final repo = await  context.read<DatasourceRepo>().expenseRepo;
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    final id = await repo.addItem(body);
    return Response(body: id);

  } on Exception catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _deleteAllExpenses(RequestContext context) async{
  final repo = await context.read<DatasourceRepo>().expenseRepo;

  try {
    await repo.deleteAllItem();

    return Response(body: 'All Expenses deleted');
  } on Exception catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}
