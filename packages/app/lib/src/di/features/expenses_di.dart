import 'package:app/src/di/service_locator.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:feature_expense_detail/feature_expense_detail.dart';
import 'package:feature_expenses_list/feature_expenses_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupExpensesDI() async {
  getIt
    ..registerSingleton<ExpenseLocalDataSource>(
      ExpenseLocalDataSourceImpl(prefs: getIt<SharedPreferences>()),
    )
    ..registerSingleton<ExpenseRepository>(
      ExpenseRepositoryImpl(localDataSource: getIt<ExpenseLocalDataSource>()),
    );

  registerExpensesListDependencies(getIt);
  registerExpenseDetailDependencies(getIt);
}
