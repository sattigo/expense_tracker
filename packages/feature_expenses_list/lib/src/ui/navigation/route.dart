import 'package:core_navigation/core_navigation.dart';
import 'package:feature_expenses_list/src/ui/widgets/view.dart';

class ExpenseListRoute {
  static const String path = '/';

  static List<RouteBase> get routes => [
    AppGoRoute(path: path, name: Routes.expenseList, builder: (context, state) => const ExpenseListView()),
  ];
}
