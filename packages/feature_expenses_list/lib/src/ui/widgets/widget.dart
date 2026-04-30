import 'dart:async';

import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:core_navigation/core_navigation.dart';
import 'package:feature_expenses_list/src/ui/bloc/bloc.build.dart';
import 'package:feature_expenses_list/src/ui/utils/category_display.dart';
import 'package:feature_expenses_list/src/ui/utils/category_icon_mapper.dart';
import 'package:feature_expenses_list/src/ui/utils/date_formatter.dart';
import 'package:feature_expenses_list/src/ui/widgets/add_expense_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ExpenseListBloc>();
    final l10n = S.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle), elevation: 2),
      body: BlocBuilder<ExpenseListBloc, ExpenseListState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text(l10n.noExpensesYet)),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (expenses) => expenses.isEmpty
                ? Center(child: Text(l10n.noExpensesYetAddFirst))
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return _ExpenseListItem(expense: expense);
                    },
                  ),
            error: (message) => _ErrorView(bloc: bloc, message: message),
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
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (bottomSheetContext) =>
            BlocProvider.value(value: context.read<ExpenseListBloc>(), child: const AddExpenseBottomSheet()),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required ExpenseListBloc bloc, required String message}) : _message = message, _bloc = bloc;

  final ExpenseListBloc _bloc;
  final String _message;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(l10n.errorPrefix(_message)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => _bloc.add(const ExpenseListEvent.load()), child: Text(l10n.retry)),
        ],
      ),
    );
  }
}

class _ExpenseListItem extends StatelessWidget {
  const _ExpenseListItem({required Expense expense}) : _expense = expense;

  final Expense _expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => unawaited(context.pushNamed(Routes.expenseDetail, extra: _expense.id)),
      leading: CircleAvatar(
        backgroundColor: _expense.type == ExpenseType.income ? Colors.green : Colors.red,
        child: Icon(getCategoryIcon(_expense.category), color: Colors.white),
      ),
      title: Text(_expense.title),
      subtitle: Text(
        '${_expense.category.displayName(context)} • ${formatDate(_expense.date)}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Text(
        '${_expense.type == ExpenseType.income ? '+' : '-'}\$${_expense.amount.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _expense.type == ExpenseType.income ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
