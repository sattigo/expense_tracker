import 'package:core_navigation/core_navigation.dart';
import 'package:feature_chart/src/ui/widgets/view.dart';

class ChartRoute {
  static List<RouteBase> get routes => [
    AppGoRoute(path: '/chart', name: Routes.expenseChart, builder: (context, state) => const ChartView()),
  ];
}
