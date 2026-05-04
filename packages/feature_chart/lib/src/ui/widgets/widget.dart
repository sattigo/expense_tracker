import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:feature_chart/src/ui/bloc/bloc.build.dart';
import 'package:feature_chart/src/ui/mappers/expense_chart_mapper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle), elevation: 2),
      body: BlocBuilder<ChartBloc, ChartState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (expenses) =>
              expenses.isEmpty ? Center(child: Text(l10n.chartNoExpensesYet)) : _ChartContent(expenses: expenses),
          error: (message) => Center(child: Text(message)),
        ),
      ),
    );
  }
}

class _ChartContent extends StatelessWidget {
  const _ChartContent({required List<Expense> expenses}) : _expenses = expenses;

  final List<Expense> _expenses;

  @override
  Widget build(BuildContext context) {
    final mapped = ExpenseChartMapper.toSpots(_expenses);
    final spots = mapped.spots;
    final labels = mapped.labels;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [LineChartBarData(spots: spots)],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= labels.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(labels[index], style: const TextStyle(fontSize: 10)),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(reservedSize: 40)),
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
          ),
        ),
      ),
    );
  }
}
