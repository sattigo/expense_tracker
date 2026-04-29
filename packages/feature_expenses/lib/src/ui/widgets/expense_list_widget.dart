import 'package:core_bloc/core_bloc.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:core_navigation/core_navigation.dart';
import 'package:flutter/material.dart';
import '../../domain/models/expense.build.dart';
import '../../domain/models/expense_type.dart';
import '../bloc/expense_list_bloc.build.dart';
import '../utils/category_display.dart';
import '../utils/category_icon_mapper.dart';
import '../utils/date_formatter.dart';
import 'add_expense_bottom_sheet.dart';

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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) =>
          BlocProvider.value(value: context.read<ExpenseListBloc>(), child: const AddExpenseBottomSheet()),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.bloc, required this.message});

  final ExpenseListBloc bloc;
  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(l10n.errorPrefix(message)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => bloc.add(const ExpenseListEvent.load()), child: Text(l10n.retry)),
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
        child: Icon(getCategoryIcon(expense.category), color: Colors.white),
      ),
      title: Text(expense.title),
      subtitle: Text(
        '${expense.category.displayName(context)} • ${formatDate(expense.date)}',
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
}
