import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';

class GetExpenseByIdUseCase {
  const GetExpenseByIdUseCase({required ExpenseRepository repository}) : _repository = repository;

  final ExpenseRepository _repository;

  Future<Result<Expense, AppFailure>> call(String id) => _repository.getExpenseById(id);
}
