import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:feature_expenses_list/feature_expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseListBloc extends Mock implements ExpenseListBloc {}

void main() {
  late MockExpenseListBloc mockBloc;

  final testExpense = Expense(
    id: 'widget-test-1',
    amount: 42,
    title: 'Widget Test Expense',
    date: DateTime(2026, 4, 28),
    category: ExpenseCategory.food,
    type: ExpenseType.expense,
  );

  setUp(() {
    mockBloc = MockExpenseListBloc();
    when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockBloc.actions).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestWidget() {
    return MaterialApp(
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      home: BlocProvider<ExpenseListBloc>.value(
        value: mockBloc,
        child: const ExpenseListWidget(),
      ),
    );
  }

  testWidgets('shows _AddItemButton and no FloatingActionButton in initial state', (tester) async {
    when(() => mockBloc.state).thenReturn(const ExpenseListState.initial());

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);
  });

  testWidgets('shows _AddItemButton and no FloatingActionButton in loading state', (tester) async {
    when(() => mockBloc.state).thenReturn(const ExpenseListState.loading());

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);
  });

  testWidgets('shows _AddItemButton and no FloatingActionButton in loaded empty state', (tester) async {
    when(() => mockBloc.state).thenReturn(const ExpenseListState.loaded([]));

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);
  });

  testWidgets('shows _AddItemButton and no FloatingActionButton in loaded state with expenses', (tester) async {
    when(() => mockBloc.state).thenReturn(ExpenseListState.loaded([testExpense]));

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);
  });

  testWidgets('shows _AddItemButton and no FloatingActionButton in error state', (tester) async {
    when(() => mockBloc.state).thenReturn(const ExpenseListState.error('something went wrong'));

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);
  });

  testWidgets('shows CircularProgressIndicator in loading state', (tester) async {
    when(() => mockBloc.state).thenReturn(const ExpenseListState.loading());

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows expense item in loaded state with expenses', (tester) async {
    when(() => mockBloc.state).thenReturn(ExpenseListState.loaded([testExpense]));

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.text(testExpense.title), findsOneWidget);
  });
}
