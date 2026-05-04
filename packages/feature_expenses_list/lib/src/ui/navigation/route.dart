import 'package:core_navigation/core_navigation.dart';
import 'package:feature_expense_detail/feature_expense_detail.dart';
import 'package:feature_expenses_list/src/ui/widgets/view.dart';

class ExpenseListRoute {
  static List<RouteBase> get routes => [
    AppGoRoute(
      path: '/',
      name: Routes.expenseList,
      builder: (context, state) => const ExpenseListView(),
      routes: ExpenseDetailRoute.routes,
    ),
  ];
}
