import 'dart:async';

import 'package:core_bloc/core_bloc.dart';
import 'package:core_event_bus/core_event_bus.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_expenses_list/src/domain/use_cases/get_expenses_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'action.dart';
part 'event.dart';
part 'state.dart';
part 'bloc.build.freezed.dart';

class ExpenseListBloc extends BaseBloc<ExpenseListEvent, ExpenseListState, ExpenseListAction> {
  ExpenseListBloc({required GetExpensesUseCase getExpensesUseCase, required AppEventBus eventBus})
    : _getExpensesUseCase = getExpensesUseCase,
      super(const ExpenseListState.initial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<OpenDetailEvent>(_onOpenDetail);
    _eventBusSubscription = eventBus.on<TransactionAdded>().listen((_) => add(const ExpenseListEvent.load()));
  }

  final GetExpensesUseCase _getExpensesUseCase;
  late final StreamSubscription<TransactionAdded> _eventBusSubscription;

  Future<void> _onLoadExpenses(LoadExpenses event, Emitter<ExpenseListState> emit) async {
    emit(const ExpenseListState.loading());

    final result = await _getExpensesUseCase();

    switch (result) {
      case Success(:final data):
        emit(ExpenseListState.loaded(data));
      case Error(:final error):
        emit(ExpenseListState.error(error.message));
    }
  }

  void _onOpenDetail(OpenDetailEvent event, Emitter<ExpenseListState> emit) {
    emitAction(ExpenseListAction.openDetail(event.expenseId));
  }

  @override
  Future<void> close() async {
    await _eventBusSubscription.cancel();
    return super.close();
  }
}
