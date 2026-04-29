import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';
import '../models/expense.build.dart';
import '../repositories/expense_repository.dart';

class GetExpensesUseCase {
  const GetExpensesUseCase(this._repository);

  final ExpenseRepository _repository;

  Future<Result<List<Expense>, AppFailure>> call() async {
    return await _repository.getExpenses();
  }
}
