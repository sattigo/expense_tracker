import 'dart:convert';

import 'package:core_expense_domain/src/data/data_sources/local/contract.dart';
import 'package:core_expense_domain/src/data/dto/expense_dto.build.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  const ExpenseLocalDataSourceImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;
  static const String _key = 'expenses';

  @override
  Future<List<ExpenseDto>> getExpenses() async {
    final jsonString = _prefs.getString(_key);
    if (jsonString == null) {
      return [];
    }

    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList.map((json) => ExpenseDto.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> saveExpense(ExpenseDto expense) async {
    final expenses = await getExpenses();
    expenses.add(expense);

    final jsonList = expenses.map((e) => e.toJson()).toList();
    await _prefs.setString(_key, jsonEncode(jsonList));
  }

  @override
  Future<ExpenseDto?> getExpenseById(String id) async {
    final expenses = await getExpenses();
    return expenses.where((e) => e.id == id).firstOrNull;
  }
}
