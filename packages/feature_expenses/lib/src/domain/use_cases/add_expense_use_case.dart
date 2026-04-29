import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';
import '../models/expense.build.dart';
import '../repositories/expense_repository.dart';

class AddExpenseUseCase {
  const AddExpenseUseCase(this._repository);

  final ExpenseRepository _repository;

  Future<Result<void, AppFailure>> call(Expense expense) async {
    return await _repository.addExpense(expense);
  }
}
