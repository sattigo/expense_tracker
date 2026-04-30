import 'package:core_expense_domain/src/data/data_sources/local/contract.dart';
import 'package:core_expense_domain/src/data/dto/expense_dto.build.dart';
import 'package:core_expense_domain/src/domain/models/expense.build.dart';
import 'package:core_expense_domain/src/domain/repositories/contract.dart';
import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';

final class ExpenseRepositoryImpl implements ExpenseRepository {
  const ExpenseRepositoryImpl({required ExpenseLocalDataSource localDataSource}) : _localDataSource = localDataSource;

  final ExpenseLocalDataSource _localDataSource;

  @override
  Future<Result<List<Expense>, AppFailure>> getExpenses() async {
    try {
      final dtos = await _localDataSource.getExpenses();
      final expenses = dtos.map((dto) => dto.toDomain()).toList();
      return Success(expenses);
    } on Exception catch (e) {
      return Failure(StorageFailure('Failed to load expenses: $e'));
    }
  }

  @override
  Future<Result<void, AppFailure>> addExpense(Expense expense) async {
    try {
      final dto = ExpenseDtoMapper.fromDomain(expense);
      await _localDataSource.saveExpense(dto);
      return const Success(null);
    } on Exception catch (e) {
      return Failure(StorageFailure('Failed to save expense: $e'));
    }
  }

  @override
  Future<Result<Expense, AppFailure>> getExpenseById(String id) async {
    try {
      final dto = await _localDataSource.getExpenseById(id);
      if (dto == null) {
        return Failure(StorageFailure('Expense with id $id not found'));
      }
      return Success(dto.toDomain());
    } on Exception catch (e) {
      return Failure(StorageFailure('Failed to load expense: $e'));
    }
  }
}
