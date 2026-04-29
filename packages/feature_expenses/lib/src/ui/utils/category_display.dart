import 'package:core_l10n/core_l10n.dart';
import 'package:feature_expenses/src/domain/models/expense_category.dart';
import 'package:flutter/widgets.dart';

extension ExpenseCategoryDisplay on ExpenseCategory {
  String displayName(BuildContext context) {
    final l10n = S.of(context)!;
    return switch (this) {
      ExpenseCategory.food => l10n.categoryFood,
      ExpenseCategory.transport => l10n.categoryTransport,
      ExpenseCategory.entertainment => l10n.categoryEntertainment,
      ExpenseCategory.shopping => l10n.categoryShopping,
      ExpenseCategory.health => l10n.categoryHealth,
      ExpenseCategory.other => l10n.categoryOther,
    };
  }
}
