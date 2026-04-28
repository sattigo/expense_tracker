part of 'expense_detail_bloc.build.dart';

@freezed
abstract class ExpenseDetailState with _$ExpenseDetailState {
  const factory ExpenseDetailState.initial() = _Initial;
  const factory ExpenseDetailState.loading() = _Loading;
  const factory ExpenseDetailState.loaded(Expense expense) = _Loaded;
  const factory ExpenseDetailState.error(String message) = _Error;
}
