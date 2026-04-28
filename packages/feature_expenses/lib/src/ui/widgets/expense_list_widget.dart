import 'package:core_bloc/core_bloc.dart';
import 'package:core_navigation/core_navigation.dart';
import 'package:flutter/material.dart';
import '../../domain/models/expense.build.dart';
import '../../domain/models/expense_category.dart';
import '../../domain/models/expense_type.dart';
import '../bloc/expense_list_bloc.build.dart';
import 'add_expense_bottom_sheet.dart';

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker'), elevation: 2),
      body: BlocBuilder<ExpenseListBloc, ExpenseListState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('No expenses yet')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (expenses) => expenses.isEmpty
                ? const Center(child: Text('No expenses yet. Add your first expense!'))
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return _ExpenseListItem(expense: expense);
                    },
                  ),
            error: (message) => _ErrorView(message: message),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExpenseBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddExpenseBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) =>
          BlocProvider.value(value: context.read<ExpenseListBloc>(), child: const AddExpenseBottomSheet()),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ExpenseListBloc>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: $message'),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => bloc.add(const ExpenseListEvent.load()), child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _ExpenseListItem extends StatelessWidget {
  const _ExpenseListItem({required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(Routes.expenseDetail, extra: expense.id);
      },
      leading: CircleAvatar(
        backgroundColor: expense.type == ExpenseType.income ? Colors.green : Colors.red,
        child: Icon(_getCategoryIcon(expense.category), color: Colors.white),
      ),
      title: Text(expense.title),
      subtitle: Text(
        '${expense.category.displayName} • ${_formatDate(expense.date)}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Text(
        '${expense.type == ExpenseType.income ? '+' : '-'}\$${expense.amount.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: expense.type == ExpenseType.income ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  IconData _getCategoryIcon(ExpenseCategory category) {
    return switch (category) {
      ExpenseCategory.food => Icons.restaurant,
      ExpenseCategory.transport => Icons.directions_car,
      ExpenseCategory.entertainment => Icons.movie,
      ExpenseCategory.shopping => Icons.shopping_bag,
      ExpenseCategory.health => Icons.health_and_safety,
      ExpenseCategory.other => Icons.category,
    };
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
