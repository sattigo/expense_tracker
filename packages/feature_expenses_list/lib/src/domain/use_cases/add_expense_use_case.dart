import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';

class AddExpenseUseCase {
  const AddExpenseUseCase({required ExpenseRepository repository}) : _repository = repository;

  final ExpenseRepository _repository;

  Future<Result<void, AppFailure>> call(Expense expense) => _repository.addExpense(expense);
}
