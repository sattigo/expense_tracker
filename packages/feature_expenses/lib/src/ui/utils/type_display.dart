import 'package:core_l10n/core_l10n.dart';
import 'package:feature_expenses/src/domain/models/expense_type.dart';
import 'package:flutter/widgets.dart';

extension ExpenseTypeDisplay on ExpenseType {
  String displayName(BuildContext context) {
    final l10n = S.of(context)!;
    return switch (this) {
      ExpenseType.income => l10n.typeIncome,
      ExpenseType.expense => l10n.typeExpense,
    };
  }
}
