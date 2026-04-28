import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';
import '../models/expense.build.dart';
import '../repositories/expense_repository.dart';

class GetExpenseByIdUseCase {
  const GetExpenseByIdUseCase(this._repository);

  final ExpenseRepository _repository;

  Future<Result<Expense, AppFailure>> call(String id) async {
    return await _repository.getExpenseById(id);
  }
}
