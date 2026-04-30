import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:feature_expenses_list/src/domain/use_cases/add_expense_use_case.dart';
import 'package:feature_expenses_list/src/domain/use_cases/get_expenses_use_case.dart';
import 'package:feature_expenses_list/src/ui/bloc/bloc.build.dart';
import 'package:get_it/get_it.dart';

void registerExpensesListDependencies(GetIt getIt) {
  getIt
    ..registerSingleton<GetExpensesUseCase>(GetExpensesUseCase(repository: getIt<ExpenseRepository>()))
    ..registerSingleton<AddExpenseUseCase>(AddExpenseUseCase(repository: getIt<ExpenseRepository>()))
    ..registerFactory<ExpenseListBloc>(
      () => ExpenseListBloc(
        getExpensesUseCase: getIt<GetExpensesUseCase>(),
        addExpenseUseCase: getIt<AddExpenseUseCase>(),
      ),
    );
}
