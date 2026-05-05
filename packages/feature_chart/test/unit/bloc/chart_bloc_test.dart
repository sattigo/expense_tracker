import 'dart:async';

import 'package:core_event_bus/core_event_bus.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_chart/feature_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

class MockAppEventBus extends Mock implements AppEventBus {}

void main() {
  late MockExpenseRepository mockRepository;
  late MockAppEventBus mockEventBus;
  late StreamController<TransactionAdded> transactionAddedController;
  late GetExpensesForChartUseCase getExpensesForChartUseCase;
  late ChartBloc bloc;

  final testExpense = Expense(
    id: 'chart-test-id-1',
    amount: 150,
    title: 'Chart Test Expense',
    date: DateTime(2026, 4, 15),
    category: ExpenseCategory.food,
    type: ExpenseType.expense,
  );

  setUpAll(() {
    registerFallbackValue(testExpense);
  });

  setUp(() {
    mockRepository = MockExpenseRepository();
    mockEventBus = MockAppEventBus();
    transactionAddedController = StreamController<TransactionAdded>.broadcast();
    when(() => mockEventBus.on<TransactionAdded>()).thenAnswer((_) => transactionAddedController.stream);
    getExpensesForChartUseCase = GetExpensesForChartUseCase(repository: mockRepository);
    bloc = ChartBloc(getExpensesForChartUseCase: getExpensesForChartUseCase, eventBus: mockEventBus);
  });

  tearDown(() async {
    await bloc.close();
    await transactionAddedController.close();
  });

  group('ChartBloc', () {
    test('initial state is ChartState.initial', () {
      expect(bloc.state, const ChartState.initial());
    });

    test('emits [loading, loaded([])] when repository returns empty list', () async {
      when(() => mockRepository.getExpenses()).thenAnswer((_) async => const Result.success([]));

      final expectedStates = [const ChartState.loading(), const ChartState.loaded([])];

      unawaited(expectLater(bloc.stream, emitsInOrder(expectedStates)));

      bloc.add(const ChartEvent.load());

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenses()).called(1);
    });

    test('emits [loading, loaded([expense])] when repository returns data', () async {
      when(() => mockRepository.getExpenses()).thenAnswer((_) async => Result.success([testExpense]));

      final expectedStates = [const ChartState.loading(), ChartState.loaded([testExpense])];

      unawaited(expectLater(bloc.stream, emitsInOrder(expectedStates)));

      bloc.add(const ChartEvent.load());

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenses()).called(1);
    });

    test('emits [loading, error] when repository returns failure', () async {
      when(
        () => mockRepository.getExpenses(),
      ).thenAnswer((_) async => const Result.failure(StorageFailure('Failed to load chart data')));

      final expectedStates = [
        const ChartState.loading(),
        const ChartState.error('Failed to load chart data'),
      ];

      unawaited(expectLater(bloc.stream, emitsInOrder(expectedStates)));

      bloc.add(const ChartEvent.load());

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenses()).called(1);
    });

    test('reloads chart when TransactionAdded is received on event bus', () async {
      when(() => mockRepository.getExpenses()).thenAnswer((_) async => Result.success([testExpense]));

      transactionAddedController.add(const TransactionAdded());

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenses()).called(1);
    });
  });
}
