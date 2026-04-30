import 'package:core_l10n/core_l10n.dart';
import 'package:feature_expenses/src/domain/models/expense.build.dart';
import 'package:feature_expenses/src/domain/models/expense_type.dart';
import 'package:feature_expenses/src/ui/bloc/expense_detail_bloc.build.dart';
import 'package:feature_expenses/src/ui/utils/category_display.dart';
import 'package:feature_expenses/src/ui/utils/category_icon_mapper.dart';
import 'package:feature_expenses/src/ui/utils/date_formatter.dart';
import 'package:feature_expenses/src/ui/utils/type_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  const _ExpenseDetailContent({required Expense expense}) : _expense = expense;

  final Expense _expense;

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
              backgroundColor: _expense.type == ExpenseType.income ? Colors.green : Colors.red,
              child: Icon(getCategoryIcon(_expense.category), size: 48, color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              '${_expense.type == ExpenseType.income ? '+' : '-'}\$${_expense.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _expense.type == ExpenseType.income ? Colors.green : Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _DetailRow(label: l10n.title, value: _expense.title),
          const Divider(),
          _DetailRow(label: l10n.type, value: _expense.type.displayName(context)),
          const Divider(),
          _DetailRow(label: l10n.category, value: _expense.category.displayName(context)),
          const Divider(),
          _DetailRow(label: l10n.date, value: formatDate(_expense.date)),
          const Divider(),
          _DetailRow(label: l10n.transactionId, value: _expense.id),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required String label, required String value}) : _value = value, _label = label;

  final String _label;
  final String _value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(_label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
          ),
          Expanded(
            child: Text(_value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
