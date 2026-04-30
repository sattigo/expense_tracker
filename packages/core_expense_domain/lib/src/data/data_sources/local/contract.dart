import 'package:core_expense_domain/src/data/dto/expense_dto.build.dart';

abstract interface class ExpenseLocalDataSource {
  Future<List<ExpenseDto>> getExpenses();
  Future<void> saveExpense(ExpenseDto expense);
  Future<ExpenseDto?> getExpenseById(String id);
}
