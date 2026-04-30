import 'package:core_navigation/core_navigation.dart';
import 'package:feature_expense_detail/src/ui/widgets/view.dart';

class ExpenseDetailRoute {
  static List<RouteBase> get routes => [
    AppGoRoute(
      path: '/detail',
      name: Routes.expenseDetail,
      builder: (context, state) {
        final expenseId = state.extra! as String;
        return ExpenseDetailView(expenseId: expenseId);
      },
    ),
  ];
}
