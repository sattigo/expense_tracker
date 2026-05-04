part of 'bloc.build.dart';

@freezed
sealed class ExpenseListAction with _$ExpenseListAction {
  const factory ExpenseListAction.openDetail(String expenseId) = OpenDetail;
}
