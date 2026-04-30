part of 'bloc.build.dart';

@freezed
sealed class ExpenseDetailEvent with _$ExpenseDetailEvent {
  const factory ExpenseDetailEvent.load(String id) = LoadExpenseDetail;
  const factory ExpenseDetailEvent.requestGoBack() = RequestGoBack;
}
