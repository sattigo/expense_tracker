import 'package:core_expense_domain/core_expense_domain.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:feature_expenses_list/src/ui/bloc/bloc.build.dart';
import 'package:feature_expenses_list/src/ui/utils/category_display.dart';
import 'package:feature_expenses_list/src/ui/utils/category_icon_mapper.dart';
import 'package:feature_expenses_list/src/ui/utils/date_formatter.dart';
import 'package:feature_transaction_form/feature_transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@visibleForTesting
class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle), elevation: 2),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ExpenseListBloc, ExpenseListState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return state.when(
                  initial: () => Center(child: Text(l10n.noExpensesYet)),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  loaded: (expenses) => expenses.isEmpty
                      ? Center(child: Text(l10n.noExpensesYetAddFirst))
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
                            return _ExpenseListItem(expense: expense);
                          },
                        ),
                  error: (message) => _ErrorView(
                    message: message,
                    onRetry: () => context.read<ExpenseListBloc>().add(const ExpenseListEvent.load()),
                  ),
                );
              },
            ),
          ),
          _AddItemButton(onPressed: () => showTransactionForm(context)),
        ],
      ),
    );
  }
}

class _AddItemButton extends StatelessWidget {
  const _AddItemButton({required VoidCallback onPressed}) : _onPressed = onPressed;

  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8 + bottomInset),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: _onPressed,
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.outline,
            foregroundColor: Theme.of(context).colorScheme.surface,
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(l10n.addItem),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required String message, required VoidCallback onRetry}) : _message = message, _onRetry = onRetry;

  final String _message;
  final VoidCallback _onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(l10n.errorPrefix(_message)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _onRetry, child: Text(l10n.retry)),
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
      onTap: () => context.read<ExpenseListBloc>().add(ExpenseListEvent.openDetail(_expense.id)),
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
