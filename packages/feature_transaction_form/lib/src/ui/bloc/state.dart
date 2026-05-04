part of 'bloc.build.dart';

@freezed
abstract class TransactionFormState with _$TransactionFormState {
  const factory TransactionFormState.idle() = _Idle;
  const factory TransactionFormState.submitting() = _Submitting;
  const factory TransactionFormState.submitted() = _Submitted;
  const factory TransactionFormState.error(String message) = _Error;
}
