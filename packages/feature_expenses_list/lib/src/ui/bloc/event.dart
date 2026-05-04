part of 'bloc.build.dart';

@freezed
sealed class ExpenseListEvent with _$ExpenseListEvent {
  const factory ExpenseListEvent.load() = LoadExpenses;
  const factory ExpenseListEvent.openDetail(String expenseId) = OpenDetailEvent;
}
