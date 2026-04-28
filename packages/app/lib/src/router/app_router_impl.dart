import 'package:core_navigation/core_navigation.dart';
import 'package:feature_expenses/feature_expenses.dart';

class AppRouterImpl implements AppRouter {
  AppRouterImpl();

  @override
  late final GoRouter router = GoRouter(routes: ExpenseRoutes.routes, initialLocation: '/');
}
