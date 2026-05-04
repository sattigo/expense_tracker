import 'dart:async';

import 'package:core_bloc/core_bloc.dart';
import 'package:core_event_bus/core_event_bus.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_chart/src/domain/use_cases/get_expenses_for_chart_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'action.dart';
part 'event.dart';
part 'state.dart';
part 'bloc.build.freezed.dart';

class ChartBloc extends BaseBloc<ChartEvent, ChartState, ChartAction> {
  ChartBloc({required GetExpensesForChartUseCase getExpensesForChartUseCase, required AppEventBus eventBus})
    : _getExpensesForChartUseCase = getExpensesForChartUseCase,
      super(const ChartState.initial()) {
    on<LoadChart>(_onLoadChart);
    _eventBusSubscription = eventBus.on<TransactionAdded>().listen((_) => add(const ChartEvent.load()));
  }

  final GetExpensesForChartUseCase _getExpensesForChartUseCase;
  late final StreamSubscription<TransactionAdded> _eventBusSubscription;

  Future<void> _onLoadChart(LoadChart event, Emitter<ChartState> emit) async {
    emit(const ChartState.loading());

    final result = await _getExpensesForChartUseCase();

    switch (result) {
      case Success(:final data):
        emit(ChartState.loaded(data));
      case Error(:final error):
        emit(ChartState.error(error.message));
    }
  }

  @override
  Future<void> close() async {
    await _eventBusSubscription.cancel();
    return super.close();
  }
}
