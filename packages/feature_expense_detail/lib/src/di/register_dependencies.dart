import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:feature_expense_detail/src/domain/use_cases/get_expense_by_id_use_case.dart';
import 'package:feature_expense_detail/src/ui/bloc/bloc.build.dart';
import 'package:get_it/get_it.dart';

void registerExpenseDetailDependencies(GetIt getIt) {
  getIt
    ..registerSingleton<GetExpenseByIdUseCase>(GetExpenseByIdUseCase(repository: getIt<ExpenseRepository>()))
    ..registerFactory<ExpenseDetailBloc>(
      () => ExpenseDetailBloc(getExpenseByIdUseCase: getIt<GetExpenseByIdUseCase>()),
    );
}
