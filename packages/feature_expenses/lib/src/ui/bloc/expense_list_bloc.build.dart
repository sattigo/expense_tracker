import 'package:core_bloc/core_bloc.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_expenses/src/domain/models/expense.build.dart';
import 'package:feature_expenses/src/domain/use_cases/add_expense_use_case.dart';
import 'package:feature_expenses/src/domain/use_cases/get_expenses_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_list_event.dart';
part 'expense_list_state.dart';
part 'expense_list_bloc.build.freezed.dart';

class ExpenseListBloc extends BaseBloc<ExpenseListEvent, ExpenseListState> {
  ExpenseListBloc({required GetExpensesUseCase getExpensesUseCase, required AddExpenseUseCase addExpenseUseCase})
    : _getExpensesUseCase = getExpensesUseCase,
      _addExpenseUseCase = addExpenseUseCase,
      super(const ExpenseListState.initial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpense>(_onAddExpense);
  }

  final GetExpensesUseCase _getExpensesUseCase;
  final AddExpenseUseCase _addExpenseUseCase;

  Future<void> _onLoadExpenses(LoadExpenses event, Emitter<ExpenseListState> emit) async {
    emit(const ExpenseListState.loading());

    final result = await _getExpensesUseCase();

    switch (result) {
      case Success(:final data):
        emit(ExpenseListState.loaded(data));
      case Failure(:final failure):
        emit(ExpenseListState.error(failure.message));
    }
  }

  Future<void> _onAddExpense(AddExpense event, Emitter<ExpenseListState> emit) async {
    final result = await _addExpenseUseCase(event.expense);

    switch (result) {
      case Success():
        add(const ExpenseListEvent.load());
      case Failure(:final failure):
        emit(ExpenseListState.error(failure.message));
    }
  }
}
