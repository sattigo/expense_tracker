import 'package:app/src/di/service_locator.dart';
import 'package:core_event_bus/core_event_bus.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:feature_chart/feature_chart.dart';

Future<void> setupChartDI() async {
  getIt
    ..registerSingleton<GetExpensesForChartUseCase>(GetExpensesForChartUseCase(repository: getIt<ExpenseRepository>()))
    ..registerFactory<ChartBloc>(
      () => ChartBloc(getExpensesForChartUseCase: getIt<GetExpensesForChartUseCase>(), eventBus: getIt<AppEventBus>()),
    );
}
