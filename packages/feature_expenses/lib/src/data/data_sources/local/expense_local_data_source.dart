import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../dto/expense_dto.build.dart';

abstract interface class ExpenseLocalDataSource {
  Future<List<ExpenseDto>> getExpenses();
  Future<void> saveExpense(ExpenseDto expense);
  Future<ExpenseDto?> getExpenseById(String id);
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  ExpenseLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;
  static const String _key = 'expenses';

  @override
  Future<List<ExpenseDto>> getExpenses() async {
    final String? jsonString = _prefs.getString(_key);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
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
    try {
      return expenses.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
