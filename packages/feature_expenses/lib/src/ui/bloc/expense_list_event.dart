part of 'expense_list_bloc.build.dart';

@freezed
sealed class ExpenseListEvent with _$ExpenseListEvent {
  const factory ExpenseListEvent.load() = LoadExpenses;
  const factory ExpenseListEvent.add(Expense expense) = AddExpense;
}
