import 'package:core_bloc/core_bloc.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:flutter/material.dart';
import '../../domain/models/expense.build.dart';
import '../../domain/models/expense_type.dart';
import '../bloc/expense_detail_bloc.build.dart';
import '../utils/category_display.dart';
import '../utils/category_icon_mapper.dart';
import '../utils/date_formatter.dart';
import '../utils/type_display.dart';

class ExpenseDetailWidget extends StatelessWidget {
  const ExpenseDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.transactionDetails), elevation: 2),
      body: BlocBuilder<ExpenseDetailBloc, ExpenseDetailState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text(l10n.noData)),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (expense) => _ExpenseDetailContent(expense: expense),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.errorPrefix(message)),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.goBack)),
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
    final l10n = S.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: expense.type == ExpenseType.income ? Colors.green : Colors.red,
              child: Icon(getCategoryIcon(expense.category), size: 48, color: Colors.white),
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
          _DetailRow(label: l10n.title, value: expense.title),
          const Divider(),
          _DetailRow(label: l10n.type, value: expense.type.displayName(context)),
          const Divider(),
          _DetailRow(label: l10n.category, value: expense.category.displayName(context)),
          const Divider(),
          _DetailRow(label: l10n.date, value: formatDate(expense.date)),
          const Divider(),
          _DetailRow(label: l10n.transactionId, value: expense.id),
        ],
      ),
    );
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
