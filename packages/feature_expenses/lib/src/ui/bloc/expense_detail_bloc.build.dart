import 'package:core_bloc/core_bloc.dart';
import 'package:core_result/core_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/expense.build.dart';
import '../../domain/use_cases/get_expense_by_id_use_case.dart';

part 'expense_detail_event.dart';
part 'expense_detail_state.dart';
part 'expense_detail_bloc.build.freezed.dart';

class ExpenseDetailBloc extends BaseBloc<ExpenseDetailEvent, ExpenseDetailState> {
  ExpenseDetailBloc({required GetExpenseByIdUseCase getExpenseByIdUseCase})
    : _getExpenseByIdUseCase = getExpenseByIdUseCase,
      super(const ExpenseDetailState.initial()) {
    on<LoadExpenseDetail>(_onLoadExpenseDetail);
  }

  final GetExpenseByIdUseCase _getExpenseByIdUseCase;

  Future<void> _onLoadExpenseDetail(LoadExpenseDetail event, Emitter<ExpenseDetailState> emit) async {
    emit(const ExpenseDetailState.loading());

    final result = await _getExpenseByIdUseCase(event.id);

    switch (result) {
      case Success(:final data):
        emit(ExpenseDetailState.loaded(data));
      case Failure(:final failure):
        emit(ExpenseDetailState.error(failure.message));
    }
  }
}
