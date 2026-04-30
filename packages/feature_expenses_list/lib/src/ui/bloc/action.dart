part of 'bloc.build.dart';

@freezed
sealed class ExpenseListAction with _$ExpenseListAction {
  const factory ExpenseListAction.openDetail(String expenseId) = OpenDetail;
  const factory ExpenseListAction.openAddExpenseForm() = OpenAddExpenseForm;
  const factory ExpenseListAction.closeAddExpenseForm() = CloseAddExpenseForm;
}
