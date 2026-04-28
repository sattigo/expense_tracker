import 'package:feature_expenses/feature_expenses_internal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service_locator.dart';

Future<void> setupExpensesDI() async {
  getIt.registerSingleton<ExpenseLocalDataSource>(ExpenseLocalDataSourceImpl(getIt<SharedPreferences>()));

  getIt.registerSingleton<ExpenseRepository>(ExpenseRepositoryImpl(getIt<ExpenseLocalDataSource>()));

  getIt.registerSingleton<GetExpensesUseCase>(GetExpensesUseCase(getIt<ExpenseRepository>()));

  getIt.registerSingleton<AddExpenseUseCase>(AddExpenseUseCase(getIt<ExpenseRepository>()));

  getIt.registerSingleton<GetExpenseByIdUseCase>(GetExpenseByIdUseCase(getIt<ExpenseRepository>()));

  getIt.registerFactory<ExpenseListBloc>(
    () =>
        ExpenseListBloc(getExpensesUseCase: getIt<GetExpensesUseCase>(), addExpenseUseCase: getIt<AddExpenseUseCase>()),
  );

  getIt.registerFactory<ExpenseDetailBloc>(
    () => ExpenseDetailBloc(getExpenseByIdUseCase: getIt<GetExpenseByIdUseCase>()),
  );
}
