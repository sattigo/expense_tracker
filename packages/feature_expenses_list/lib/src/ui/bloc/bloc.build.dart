import 'package:core_bloc/core_bloc.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_expenses_list/src/domain/use_cases/add_expense_use_case.dart';
import 'package:feature_expenses_list/src/domain/use_cases/get_expenses_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'action.dart';
part 'event.dart';
part 'state.dart';
part 'bloc.build.freezed.dart';

class ExpenseListBloc extends BaseBloc<ExpenseListEvent, ExpenseListState, ExpenseListAction> {
  ExpenseListBloc({required GetExpensesUseCase getExpensesUseCase, required AddExpenseUseCase addExpenseUseCase})
    : _getExpensesUseCase = getExpensesUseCase,
      _addExpenseUseCase = addExpenseUseCase,
      super(const ExpenseListState.initial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpense>(_onAddExpense);
    on<RequestAddExpense>(_onRequestAddExpense);
    on<OpenDetailEvent>(_onOpenDetail);
  }

  final GetExpensesUseCase _getExpensesUseCase;
  final AddExpenseUseCase _addExpenseUseCase;

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

  Future<void> _onAddExpense(AddExpense event, Emitter<ExpenseListState> emit) async {
    final result = await _addExpenseUseCase(event.expense);

    switch (result) {
      case Success():
        emitAction(const ExpenseListAction.closeAddExpenseForm());
        add(const ExpenseListEvent.load());
      case Error(:final error):
        emit(ExpenseListState.error(error.message));
    }
  }

  void _onRequestAddExpense(RequestAddExpense event, Emitter<ExpenseListState> emit) {
    emitAction(const ExpenseListAction.openAddExpenseForm());
  }

  void _onOpenDetail(OpenDetailEvent event, Emitter<ExpenseListState> emit) {
    emitAction(ExpenseListAction.openDetail(event.expenseId));
  }
}
