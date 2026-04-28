part of 'expense_detail_bloc.build.dart';

@freezed
sealed class ExpenseDetailEvent with _$ExpenseDetailEvent {
  const factory ExpenseDetailEvent.load(String id) = LoadExpenseDetail;
}
