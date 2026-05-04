part of 'bloc.build.dart';

@freezed
sealed class TransactionFormAction with _$TransactionFormAction {
  const factory TransactionFormAction.closeForm() = CloseForm;
}
