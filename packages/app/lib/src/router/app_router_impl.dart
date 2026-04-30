import 'package:core_navigation/core_navigation.dart';
import 'package:feature_expense_detail/feature_expense_detail.dart';
import 'package:feature_expenses_list/feature_expenses_list.dart';

class AppRouterImpl implements AppRouter {
  AppRouterImpl();

  @override
  late final GoRouter router = GoRouter(
    routes: [
      ...ExpenseListRoute.routes,
      ...ExpenseDetailRoute.routes,
    ],
    initialLocation: '/',
  );
}
