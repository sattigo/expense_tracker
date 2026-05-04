import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:feature_chart/src/ui/mappers/expense_chart_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpenseChartMapper', () {
    test('income expense produces positive y value', () {
      final expense = Expense(
        id: '1',
        amount: 200,
        title: 'Salary',
        date: DateTime(2026, 1, 15),
        category: ExpenseCategory.other,
        type: ExpenseType.income,
      );

      final result = ExpenseChartMapper.toSpots([expense]);

      expect(result.spots.first.y, 200.0);
    });

    test('expense type produces negative y value', () {
      final expense = Expense(
        id: '2',
        amount: 50,
        title: 'Lunch',
        date: DateTime(2026, 1, 16),
        category: ExpenseCategory.food,
        type: ExpenseType.expense,
      );

      final result = ExpenseChartMapper.toSpots([expense]);

      expect(result.spots.first.y, -50.0);
    });

    test('spots are sorted by date ascending', () {
      final older = Expense(
        id: '1',
        amount: 100,
        title: 'Older',
        date: DateTime(2026, 1, 10),
        category: ExpenseCategory.other,
        type: ExpenseType.expense,
      );
      final newer = Expense(
        id: '2',
        amount: 200,
        title: 'Newer',
        date: DateTime(2026, 1, 20),
        category: ExpenseCategory.other,
        type: ExpenseType.income,
      );

      final result = ExpenseChartMapper.toSpots([newer, older]);

      expect(result.spots[0].x, 0.0);
      expect(result.spots[0].y, -100.0);
      expect(result.spots[1].x, 1.0);
      expect(result.spots[1].y, 200.0);
    });

    test('label is formatted as dd.MM.yy', () {
      final expense = Expense(
        id: '1',
        amount: 75,
        title: 'Test',
        date: DateTime(2026, 3, 5),
        category: ExpenseCategory.transport,
        type: ExpenseType.expense,
      );

      final result = ExpenseChartMapper.toSpots([expense]);

      expect(result.labels.first, '05.03.26');
    });

    test('spots and labels have matching length', () {
      final expenses = [
        Expense(
          id: '1',
          amount: 100,
          title: 'A',
          date: DateTime(2026, 1, 5),
          category: ExpenseCategory.food,
          type: ExpenseType.expense,
        ),
        Expense(
          id: '2',
          amount: 200,
          title: 'B',
          date: DateTime(2026, 1, 12),
          category: ExpenseCategory.food,
          type: ExpenseType.income,
        ),
      ];

      final result = ExpenseChartMapper.toSpots(expenses);

      expect(result.spots.length, 2);
      expect(result.labels.length, 2);
    });

    test('empty list produces empty spots and labels', () {
      final result = ExpenseChartMapper.toSpots([]);

      expect(result.spots, isEmpty);
      expect(result.labels, isEmpty);
    });
  });
}
