enum ExpenseCategory {
  food,
  transport,
  entertainment,
  shopping,
  health,
  other;

  String get displayName {
    return switch (this) {
      ExpenseCategory.food => 'Food',
      ExpenseCategory.transport => 'Transport',
      ExpenseCategory.entertainment => 'Entertainment',
      ExpenseCategory.shopping => 'Shopping',
      ExpenseCategory.health => 'Health',
      ExpenseCategory.other => 'Other',
    };
  }
}
