part of 'bloc.build.dart';

@freezed
sealed class ExpenseDetailAction with _$ExpenseDetailAction {
  const factory ExpenseDetailAction.goBack() = GoBack;
}
