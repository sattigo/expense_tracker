import 'dart:async';

import 'package:core_event_bus/core_event_bus.dart';
import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_transaction_form/feature_transaction_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

class MockAppEventBus extends Mock implements AppEventBus {}

void main() {
  late MockExpenseRepository mockRepository;
  late MockAppEventBus mockEventBus;
  late AddTransactionUseCase addTransactionUseCase;
  late TransactionFormBloc bloc;

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
    registerFallbackValue(const TransactionAdded());
  });

  setUp(() {
    mockRepository = MockExpenseRepository();
    mockEventBus = MockAppEventBus();
    addTransactionUseCase = AddTransactionUseCase(repository: mockRepository);
    bloc = TransactionFormBloc(
      addTransactionUseCase: addTransactionUseCase,
      eventBus: mockEventBus,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  group('TransactionFormBloc', () {
    test('initial state is TransactionFormState.idle', () {
      expect(bloc.state, const TransactionFormState.idle());
    });

    test('Submit success emits [submitting, submitted], emits TransactionAdded, emits CloseForm action', () async {
      when(() => mockRepository.addExpense(any())).thenAnswer((_) async => const Result.success(null));
      when(() => mockEventBus.emit(any())).thenAnswer((_) {});

      final expectedStates = [
        const TransactionFormState.submitting(),
        const TransactionFormState.submitted(),
      ];

      unawaited(expectLater(bloc.stream, emitsInOrder(expectedStates)));
      unawaited(expectLater(bloc.actions, emits(const TransactionFormAction.closeForm())));

      bloc.add(TransactionFormEvent.submit(
        title: 'Test',
        amount: 100,
        type: ExpenseType.expense,
        category: ExpenseCategory.food,
        date: DateTime(2026, 4, 28),
      ));

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockEventBus.emit(any(that: isA<TransactionAdded>()))).called(1);
    });

    test('Submit fail emits [submitting, error], never emits TransactionAdded, CloseForm not emitted', () async {
      when(
        () => mockRepository.addExpense(any()),
      ).thenAnswer((_) async => const Result.failure(StorageFailure('msg')));

      final expectedStates = [
        const TransactionFormState.submitting(),
        const TransactionFormState.error('msg'),
      ];

      unawaited(expectLater(bloc.stream, emitsInOrder(expectedStates)));

      bloc.add(TransactionFormEvent.submit(
        title: 'Test',
        amount: 100,
        type: ExpenseType.expense,
        category: ExpenseCategory.food,
        date: DateTime(2026, 4, 28),
      ));

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verifyNever(() => mockEventBus.emit(any()));
    });
  });
}
