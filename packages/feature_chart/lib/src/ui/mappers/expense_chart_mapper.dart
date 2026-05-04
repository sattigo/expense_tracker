import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

abstract final class ExpenseChartMapper {
  static ({List<FlSpot> spots, List<String> labels}) toSpots(List<Expense> expenses) {
    final sorted = List<Expense>.from(expenses)..sort((a, b) => a.date.compareTo(b.date));
    final dateFormat = DateFormat('dd.MM.yy');

    final spots = <FlSpot>[];
    final labels = <String>[];

    for (var i = 0; i < sorted.length; i++) {
      final expense = sorted[i];
      final y = expense.type == ExpenseType.income ? expense.amount : -expense.amount;
      spots.add(FlSpot(i.toDouble(), y));
      labels.add(dateFormat.format(expense.date));
    }

    return (spots: spots, labels: labels);
  }
}
