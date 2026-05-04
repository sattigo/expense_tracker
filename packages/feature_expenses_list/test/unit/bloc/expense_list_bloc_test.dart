import 'dart:async';

import 'package:core_event_bus/core_event_bus.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_expenses_list/src/domain/use_cases/get_expenses_use_case.dart';
import 'package:feature_expenses_list/src/ui/bloc/bloc.build.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

class MockAppEventBus extends Mock implements AppEventBus {}

void main() {
  late MockExpenseRepository mockRepository;
  late MockAppEventBus mockEventBus;
  late StreamController<TransactionAdded> transactionAddedController;
  late GetExpensesUseCase getExpensesUseCase;
  late ExpenseListBloc bloc;

  final testExpense = Expense(
    id: 'test-id-1',
    amount: 100,
    title: 'Test Expense',
    date: DateTime(2026, 4, 28),
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
    getExpensesUseCase = GetExpensesUseCase(repository: mockRepository);
    bloc = ExpenseListBloc(getExpensesUseCase: getExpensesUseCase, eventBus: mockEventBus);
  });

  tearDown(() async {
    await bloc.close();
    await transactionAddedController.close();
  });

  group('ExpenseListBloc', () {
    test('initial state is ExpenseListState.initial', () {
      expect(bloc.state, const ExpenseListState.initial());
    });

    test('emits [loading, loaded] when LoadExpenses succeeds', () async {
      when(() => mockRepository.getExpenses()).thenAnswer((_) async => Result.success([testExpense]));

      final expectedStates = [
        const ExpenseListState.loading(),
        ExpenseListState.loaded([testExpense]),
      ];

      unawaited(expectLater(bloc.stream, emitsInOrder(expectedStates)));

      bloc.add(const ExpenseListEvent.load());

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenses()).called(1);
    });

    test('emits [loading, error] when LoadExpenses fails', () async {
      when(
        () => mockRepository.getExpenses(),
      ).thenAnswer((_) async => const Result.failure(StorageFailure('Failed to load expenses')));

      final expectedStates = [
        const ExpenseListState.loading(),
        const ExpenseListState.error('Failed to load expenses'),
      ];

      unawaited(expectLater(bloc.stream, emitsInOrder(expectedStates)));

      bloc.add(const ExpenseListEvent.load());

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenses()).called(1);
    });

    test('emits openDetail action when openDetail event is added', () async {
      unawaited(expectLater(bloc.actions, emits(const ExpenseListAction.openDetail('test-id-1'))));

      bloc.add(const ExpenseListEvent.openDetail('test-id-1'));

      await Future<void>.delayed(const Duration(milliseconds: 100));
    });

    test('reloads expenses when TransactionAdded is received on event bus', () async {
      when(() => mockRepository.getExpenses()).thenAnswer((_) async => Result.success([testExpense]));

      transactionAddedController.add(const TransactionAdded());

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenses()).called(1);
    });
  });
}
