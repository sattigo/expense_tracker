import 'package:flutter/material.dart';
import '../../domain/models/expense_category.dart';

IconData getCategoryIcon(ExpenseCategory category) {
  return switch (category) {
    ExpenseCategory.food => Icons.restaurant,
    ExpenseCategory.transport => Icons.directions_car,
    ExpenseCategory.entertainment => Icons.movie,
    ExpenseCategory.shopping => Icons.shopping_bag,
    ExpenseCategory.health => Icons.health_and_safety,
    ExpenseCategory.other => Icons.category,
  };
}
