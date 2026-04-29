import 'package:feature_expenses/src/domain/models/expense_category.dart';
import 'package:feature_expenses/src/domain/models/expense_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.build.freezed.dart';
part 'expense.build.g.dart';

@freezed
sealed class Expense with _$Expense {
  const factory Expense({
    required String id,
    required double amount,
    required String title,
    required DateTime date,
    required ExpenseCategory category,
    required ExpenseType type,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);
}
