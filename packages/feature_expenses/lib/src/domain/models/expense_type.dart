enum ExpenseType {
  income,
  expense;

  String get displayName {
    return switch (this) {
      ExpenseType.income => 'Income',
      ExpenseType.expense => 'Expense',
    };
  }
}
