import 'package:core_navigation/core_navigation.dart';
import 'package:feature_chart/feature_chart.dart';
import 'package:feature_expense_detail/feature_expense_detail.dart';
import 'package:feature_expenses_list/feature_expenses_list.dart';
import 'package:feature_home/feature_home.dart';

class AppRouterImpl implements AppRouter {
  AppRouterImpl();

  @override
  late final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => HomeShellWidget(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              AppGoRoute(
                path: ExpenseListRoute.path,
                name: Routes.expenseList,
                builder: (context, state) => const ExpenseListView(),
                routes: ExpenseDetailRoute.routes,
              ),
            ],
          ),
          StatefulShellBranch(routes: [...ChartRoute.routes]),
        ],
      ),
    ],
  );
}
