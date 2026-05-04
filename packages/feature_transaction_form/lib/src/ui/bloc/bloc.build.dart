import 'dart:async';

import 'package:core_bloc/core_bloc.dart';
import 'package:core_event_bus/core_event_bus.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_transaction_form/src/domain/use_cases/add_transaction_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'action.dart';
part 'event.dart';
part 'state.dart';
part 'bloc.build.freezed.dart';

class TransactionFormBloc extends BaseBloc<TransactionFormEvent, TransactionFormState, TransactionFormAction> {
  TransactionFormBloc({required AddTransactionUseCase addTransactionUseCase, required AppEventBus eventBus})
    : _addTransactionUseCase = addTransactionUseCase,
      _eventBus = eventBus,
      super(const TransactionFormState.idle()) {
    on<SubmitTransaction>(_onSubmit);
  }

  final AddTransactionUseCase _addTransactionUseCase;
  final AppEventBus _eventBus;

  Future<void> _onSubmit(SubmitTransaction event, Emitter<TransactionFormState> emit) async {
    emit(const TransactionFormState.submitting());

    final expense = Expense(
      id: const Uuid().v4(),
      title: event.title,
      amount: event.amount,
      type: event.type,
      category: event.category,
      date: event.date,
    );

    final result = await _addTransactionUseCase(expense);

    switch (result) {
      case Success():
        _eventBus.emit(const TransactionAdded());
        emit(const TransactionFormState.submitted());
        emitAction(const TransactionFormAction.closeForm());
      case Error(:final error):
        emit(TransactionFormState.error(error.message));
    }
  }
}
