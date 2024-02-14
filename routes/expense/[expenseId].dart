import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';

FutureOr<Response> onRequest(RequestContext context, String expenseId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getExpense(context, expenseId);
    case HttpMethod.patch:
      return _updateExpense(context, expenseId);
    case HttpMethod.delete:
      return _deleteExpense(context, expenseId);
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getExpense(RequestContext context, String expenseId) async {
  final repo = await context.read<DatasourceRepo>().expenseRepo;

  try {
    final expense = await repo.getItem(expenseId);

    return Response.json(body: expense);
  } on Exception catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _updateExpense(
  RequestContext context,
  String expenseId,
) async {
  final repo = await context.read<DatasourceRepo>().expenseRepo;
  final body = await context.request.json() as Map<String, dynamic>;

  try {
    await repo.updateItem(expenseId, body);

    return Response(body: 'Expense updated');
  } on Exception catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}

Future<Response> _deleteExpense(
  RequestContext context,
  String expenseId,
) async {
  final repo = await context.read<DatasourceRepo>().expenseRepo;

  try {
    await repo.deleteItem(expenseId);

    return Response(body: 'Expense deleted');
  } on Exception catch (e) {
    return Response(
        statusCode: HttpStatus.internalServerError, body: e.toString());
  }
}
