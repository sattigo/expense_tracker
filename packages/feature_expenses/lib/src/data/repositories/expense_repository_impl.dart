import 'package:core_failure/core_failure.dart';
import 'package:core_result/core_result.dart';
import '../../domain/models/expense.build.dart';
import '../../domain/repositories/expense_repository.dart';
import '../data_sources/local/expense_local_data_source.dart';
import '../dto/expense_dto.build.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  const ExpenseRepositoryImpl(this._localDataSource);

  final ExpenseLocalDataSource _localDataSource;

  @override
  Future<Result<List<Expense>, AppFailure>> getExpenses() async {
    try {
      final dtos = await _localDataSource.getExpenses();
      final expenses = dtos.map((dto) => dto.toDomain()).toList();
      return Success(expenses);
    } catch (e) {
      return Failure(StorageFailure('Failed to load expenses: $e'));
    }
  }

  @override
  Future<Result<void, AppFailure>> addExpense(Expense expense) async {
    try {
      final dto = ExpenseDto.fromDomain(expense);
      await _localDataSource.saveExpense(dto);
      return const Success(null);
    } catch (e) {
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
    } catch (e) {
      return Failure(StorageFailure('Failed to load expense: $e'));
    }
  }
}
