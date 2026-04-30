import 'dart:async';

import 'package:core_navigation/core_navigation.dart';
import 'package:feature_expenses_list/src/ui/bloc/bloc.build.dart';
import 'package:feature_expenses_list/src/ui/widgets/add_expense_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListCoordinator extends StatefulWidget {
  const ExpenseListCoordinator({required Widget child, super.key}) : _child = child;

  final Widget _child;

  @override
  State<ExpenseListCoordinator> createState() => _ExpenseListCoordinatorState();
}

class _ExpenseListCoordinatorState extends State<ExpenseListCoordinator> {
  late final StreamSubscription<ExpenseListAction> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = context.read<ExpenseListBloc>().actions.listen(_onAction);
  }

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }

  void _onAction(ExpenseListAction action) {
    if (!mounted) {
      return;
    }
    switch (action) {
      case OpenDetail(:final expenseId):
        unawaited(context.pushNamed(Routes.expenseDetail, extra: expenseId));
      case OpenAddExpenseForm():
        final bloc = context.read<ExpenseListBloc>();
        unawaited(
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (bottomSheetContext) => BlocProvider.value(value: bloc, child: const AddExpenseBottomSheet()),
          ),
        );
      case CloseAddExpenseForm():
        Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget._child;
  }
}
