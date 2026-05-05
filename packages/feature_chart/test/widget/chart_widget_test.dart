import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:feature_chart/src/ui/bloc/bloc.build.dart';
import 'package:feature_chart/src/ui/widgets/widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChartBloc extends Mock implements ChartBloc {}

void main() {
  late MockChartBloc mockBloc;

  final testExpense = Expense(
    id: 'widget-test-1',
    amount: 100,
    title: 'Widget Test',
    date: DateTime(2026, 1, 15),
    category: ExpenseCategory.food,
    type: ExpenseType.expense,
  );

  setUp(() {
    mockBloc = MockChartBloc();
    when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestWidget() {
    return MaterialApp(
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      home: BlocProvider<ChartBloc>.value(
        value: mockBloc,
        child: const ChartWidget(),
      ),
    );
  }

  testWidgets('shows CircularProgressIndicator in loading state', (tester) async {
    when(() => mockBloc.state).thenReturn(const ChartState.loading());

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows chartNoExpensesYet text in loaded([]) state', (tester) async {
    when(() => mockBloc.state).thenReturn(const ChartState.loaded([]));

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    final l10n = S.of(tester.element(find.byType(ChartWidget)))!;
    expect(find.text(l10n.chartNoExpensesYet), findsOneWidget);
    expect(find.byType(LineChart), findsNothing);
  });

  testWidgets('shows LineChart in loaded([expense]) state', (tester) async {
    when(() => mockBloc.state).thenReturn(ChartState.loaded([testExpense]));

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(LineChart), findsOneWidget);
  });
}
