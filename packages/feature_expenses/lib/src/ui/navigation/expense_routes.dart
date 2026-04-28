import 'package:core_navigation/core_navigation.dart';
import '../widgets/expense_detail_view.dart';
import '../widgets/expense_list_view.dart';

class ExpenseRoutes {
  static List<RouteBase> get routes => [
    AppGoRoute(
      path: '/',
      name: Routes.expenseList,
      builder: (context, state) => const ExpenseListView(),
      routes: [
        AppGoRoute(
          path: 'detail',
          name: Routes.expenseDetail,
          builder: (context, state) {
            final expenseId = state.extra as String;
            return ExpenseDetailView(expenseId: expenseId);
          },
        ),
      ],
    ),
  ];
}
