import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';
import 'package:feature_expenses/src/domain/models/expense.build.dart';
import 'package:feature_expenses/src/domain/models/expense_category.dart';
import 'package:feature_expenses/src/domain/models/expense_type.dart';
import 'package:feature_expenses/src/domain/repositories/expense_repository.dart';
import 'package:feature_expenses/src/domain/use_cases/get_expense_by_id_use_case.dart';
import 'package:feature_expenses/src/ui/bloc/expense_detail_bloc.build.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

void main() {
  late MockExpenseRepository mockRepository;
  late GetExpenseByIdUseCase getExpenseByIdUseCase;
  late ExpenseDetailBloc bloc;

  final testExpense = Expense(
    id: 'test-id-1',
    amount: 100.0,
    title: 'Test Expense',
    date: DateTime(2026, 4, 28),
    category: ExpenseCategory.food,
    type: ExpenseType.expense,
  );

  setUp(() {
    mockRepository = MockExpenseRepository();
    getExpenseByIdUseCase = GetExpenseByIdUseCase(mockRepository);
    bloc = ExpenseDetailBloc(getExpenseByIdUseCase: getExpenseByIdUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('ExpenseDetailBloc', () {
    test('initial state is ExpenseDetailState.initial', () {
      expect(bloc.state, const ExpenseDetailState.initial());
    });

    test('emits [loading, loaded] when LoadExpenseDetail succeeds', () async {
      when(() => mockRepository.getExpenseById('test-id-1')).thenAnswer((_) async => Success(testExpense));

      final expectedStates = [const ExpenseDetailState.loading(), ExpenseDetailState.loaded(testExpense)];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const ExpenseDetailEvent.load('test-id-1'));

      await Future.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenseById('test-id-1')).called(1);
    });

    test('emits [loading, error] when LoadExpenseDetail fails', () async {
      when(
        () => mockRepository.getExpenseById('test-id-1'),
      ).thenAnswer((_) async => const Failure(StorageFailure('Expense not found')));

      final expectedStates = [const ExpenseDetailState.loading(), const ExpenseDetailState.error('Expense not found')];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const ExpenseDetailEvent.load('test-id-1'));

      await Future.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenseById('test-id-1')).called(1);
    });

    test('emits [loading, error] when LoadExpenseDetail with invalid id', () async {
      when(
        () => mockRepository.getExpenseById('invalid-id'),
      ).thenAnswer((_) async => const Failure(StorageFailure('Expense not found')));

      final expectedStates = [const ExpenseDetailState.loading(), const ExpenseDetailState.error('Expense not found')];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const ExpenseDetailEvent.load('invalid-id'));

      await Future.delayed(const Duration(milliseconds: 100));

      verify(() => mockRepository.getExpenseById('invalid-id')).called(1);
    });
  });
}
