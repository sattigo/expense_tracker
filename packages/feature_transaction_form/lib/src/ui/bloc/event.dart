part of 'bloc.build.dart';

@freezed
sealed class TransactionFormEvent with _$TransactionFormEvent {
  const factory TransactionFormEvent.submit({
    required String title,
    required double amount,
    required ExpenseType type,
    required ExpenseCategory category,
    required DateTime date,
  }) = SubmitTransaction;
}
