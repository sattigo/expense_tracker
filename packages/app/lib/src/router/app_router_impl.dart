import 'package:core_navigation/core_navigation.dart';
import 'package:feature_chart/feature_chart.dart';
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
          StatefulShellBranch(routes: [...ExpenseListRoute.routes]),
          StatefulShellBranch(routes: [...ChartRoute.routes]),
        ],
      ),
    ],
  );
}
