import 'package:core_bloc/core_bloc.dart';
import 'package:flutter/material.dart';
import '../../domain/models/expense.build.dart';
import '../../domain/models/expense_category.dart';
import '../../domain/models/expense_type.dart';
import '../bloc/expense_detail_bloc.build.dart';

class ExpenseDetailWidget extends StatelessWidget {
  const ExpenseDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Details'), elevation: 2),
      body: BlocBuilder<ExpenseDetailBloc, ExpenseDetailState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('No data')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (expense) => _ExpenseDetailContent(expense: expense),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: $message'),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Go Back')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ExpenseDetailContent extends StatelessWidget {
  const _ExpenseDetailContent({required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: expense.type == ExpenseType.income ? Colors.green : Colors.red,
              child: Icon(_getCategoryIcon(expense.category), size: 48, color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              '${expense.type == ExpenseType.income ? '+' : '-'}\$${expense.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: expense.type == ExpenseType.income ? Colors.green : Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _DetailRow(label: 'Title', value: expense.title),
          const Divider(),
          _DetailRow(label: 'Type', value: expense.type.displayName),
          const Divider(),
          _DetailRow(label: 'Category', value: expense.category.displayName),
          const Divider(),
          _DetailRow(label: 'Date', value: _formatDate(expense.date)),
          const Divider(),
          _DetailRow(label: 'Transaction ID', value: expense.id),
        ],
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
