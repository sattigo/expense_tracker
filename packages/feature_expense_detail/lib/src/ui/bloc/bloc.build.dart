import 'package:core_bloc/core_bloc.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_expense_detail/src/domain/use_cases/get_expense_by_id_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'action.dart';
part 'event.dart';
part 'state.dart';
part 'bloc.build.freezed.dart';

class ExpenseDetailBloc extends BaseBloc<ExpenseDetailEvent, ExpenseDetailState, ExpenseDetailAction> {
  ExpenseDetailBloc({required GetExpenseByIdUseCase getExpenseByIdUseCase})
    : _getExpenseByIdUseCase = getExpenseByIdUseCase,
      super(const ExpenseDetailState.initial()) {
    on<LoadExpenseDetail>(_onLoadExpenseDetail);
    on<RequestGoBack>(_onRequestGoBack);
  }

  final GetExpenseByIdUseCase _getExpenseByIdUseCase;

  Future<void> _onLoadExpenseDetail(LoadExpenseDetail event, Emitter<ExpenseDetailState> emit) async {
    emit(const ExpenseDetailState.loading());

    final result = await _getExpenseByIdUseCase(event.id);

    switch (result) {
      case Success(:final data):
        emit(ExpenseDetailState.loaded(data));
      case Error(:final error):
        emit(ExpenseDetailState.error(error.message));
    }
  }

  void _onRequestGoBack(RequestGoBack event, Emitter<ExpenseDetailState> emit) {
    emitAction(const ExpenseDetailAction.goBack());
  }
}
