import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/expense.build.dart';
import '../../domain/models/expense_category.dart';
import '../../domain/models/expense_type.dart';

part 'expense_dto.build.freezed.dart';
part 'expense_dto.build.g.dart';

@freezed
sealed class ExpenseDto with _$ExpenseDto {
  const ExpenseDto._();

  const factory ExpenseDto({
    required String id,
    required double amount,
    required String title,
    required String date,
    required String category,
    required String type,
  }) = _ExpenseDto;

  factory ExpenseDto.fromJson(Map<String, dynamic> json) => _$ExpenseDtoFromJson(json);

  factory ExpenseDto.fromDomain(Expense expense) {
    return ExpenseDto(
      id: expense.id,
      amount: expense.amount,
      title: expense.title,
      date: expense.date.toIso8601String(),
      category: expense.category.name,
      type: expense.type.name,
    );
  }

  Expense toDomain() {
    return Expense(
      id: id,
      amount: amount,
      title: title,
      date: DateTime.parse(date),
      category: ExpenseCategory.values.firstWhere((e) => e.name == category),
      type: ExpenseType.values.firstWhere((e) => e.name == type),
    );
  }
}
