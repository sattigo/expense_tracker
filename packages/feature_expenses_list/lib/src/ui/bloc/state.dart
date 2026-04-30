part of 'bloc.build.dart';

@freezed
abstract class ExpenseListState with _$ExpenseListState {
  const factory ExpenseListState.initial() = _Initial;
  const factory ExpenseListState.loading() = _Loading;
  const factory ExpenseListState.loaded(List<Expense> expenses) = _Loaded;
  const factory ExpenseListState.error(String message) = _Error;
}
