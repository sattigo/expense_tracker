import 'dart:async';

import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_expenses/src/domain/models/expense.build.dart';
import 'package:feature_expenses/src/domain/models/expense_category.dart';
import 'package:feature_expenses/src/domain/models/expense_type.dart';
import 'package:feature_expenses/src/domain/repositories/expense_repository.dart';
import 'package:feature_expenses/src/domain/use_cases/add_expense_use_case.dart';
import 'package:feature_expenses/src/domain/use_cases/get_expenses_use_case.dart';
import 'package:feature_expenses/src/ui/bloc/expense_list_bloc.build.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

void main() {
  late MockExpenseRepository mockRepository;
  late GetExpensesUseCase getExpensesUseCase;
  late AddExpenseUseCase addExpenseUseCase;
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
    getExpensesUseCase = GetExpensesUseCase(mockRepository);
    addExpenseUseCase = AddExpenseUseCase(mockRepository);
    bloc = ExpenseListBloc(getExpensesUseCase: getExpensesUseCase, addExpenseUseCase: addExpenseUseCase);
  });

  tearDown(() async {
    await bloc.close();
  });

  group('ExpenseListBloc', () {
    test('initial state is ExpenseListState.initial', () {
      expect(bloc.state, const ExpenseListState.initial());
    });

    test('emits [loading, loaded] when LoadExpenses succeeds', () async {
      when(() => mockRepository.getExpenses()).thenAnswer((_) async => Success([testExpense]));

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
      ).thenAnswer((_) async => const Failure(StorageFailure('Failed to load expenses')));

      final expectedStates = [
        const ExpenseListState.loading(),
        const ExpenseListState.error('Failed to load expenses'),
      ];

      unawaited(expectLater(bloc.stream, emitsInOrder(expectedStates)));

      bloc.add(const ExpenseListEvent.load());

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenses()).called(1);
    });

    test('emits [loading, loaded] when AddExpense succeeds and reloads list', () async {
      when(() => mockRepository.addExpense(any())).thenAnswer((_) async => const Success(null));
      when(() => mockRepository.getExpenses()).thenAnswer((_) async => Success([testExpense]));

      final expectedStates = [
        const ExpenseListState.loading(),
        ExpenseListState.loaded([testExpense]),
      ];

      unawaited(expectLater(bloc.stream, emitsInOrder(expectedStates)));

      bloc.add(ExpenseListEvent.add(testExpense));

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.addExpense(testExpense)).called(1);
      verify(() => mockRepository.getExpenses()).called(1);
    });

    test('emits [error] when AddExpense fails', () async {
      when(
        () => mockRepository.addExpense(any()),
      ).thenAnswer((_) async => const Failure(StorageFailure('Failed to add expense')));

      final expectedStates = [const ExpenseListState.error('Failed to add expense')];

      unawaited(expectLater(bloc.stream, emitsInOrder(expectedStates)));

      bloc.add(ExpenseListEvent.add(testExpense));

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.addExpense(testExpense)).called(1);
      verifyNever(() => mockRepository.getExpenses());
    });
  });
}
