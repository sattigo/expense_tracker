part of 'bloc.build.dart';

@freezed
sealed class ExpenseListEvent with _$ExpenseListEvent {
  const factory ExpenseListEvent.load() = LoadExpenses;
  const factory ExpenseListEvent.add(Expense expense) = AddExpense;
  const factory ExpenseListEvent.requestAddExpense() = RequestAddExpense;
  const factory ExpenseListEvent.openDetail(String expenseId) = OpenDetailEvent;
}
