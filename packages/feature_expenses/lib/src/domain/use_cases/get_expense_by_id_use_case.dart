import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_expenses/src/domain/models/expense.build.dart';
import 'package:feature_expenses/src/domain/repositories/expense_repository.dart';

class GetExpenseByIdUseCase {
  const GetExpenseByIdUseCase(this._repository);

  final ExpenseRepository _repository;

  Future<Result<Expense, AppFailure>> call(String id) =>
      _repository.getExpenseById(id);
}
