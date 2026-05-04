import 'package:app/src/di/service_locator.dart';
import 'package:core_event_bus/core_event_bus.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:feature_transaction_form/feature_transaction_form.dart';

Future<void> setupTransactionFormDI() async {
  getIt
    ..registerSingleton<AddTransactionUseCase>(AddTransactionUseCase(repository: getIt<ExpenseRepository>()))
    ..registerFactory<TransactionFormBloc>(
      () => TransactionFormBloc(addTransactionUseCase: getIt<AddTransactionUseCase>(), eventBus: getIt<AppEventBus>()),
    );
}
