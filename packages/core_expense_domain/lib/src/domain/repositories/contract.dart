import 'package:core_expense_domain/src/domain/models/expense.build.dart';
import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';

abstract interface class ExpenseRepository {
  Future<Result<List<Expense>, AppFailure>> getExpenses();
  Future<Result<void, AppFailure>> addExpense(Expense expense);
  Future<Result<Expense, AppFailure>> getExpenseById(String id);
}
