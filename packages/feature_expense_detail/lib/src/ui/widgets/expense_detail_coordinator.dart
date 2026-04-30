import 'dart:async';

import 'package:feature_expense_detail/src/ui/bloc/bloc.build.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseDetailCoordinator extends StatefulWidget {
  const ExpenseDetailCoordinator({required Widget child, super.key}) : _child = child;

  final Widget _child;

  @override
  State<ExpenseDetailCoordinator> createState() => _ExpenseDetailCoordinatorState();
}

class _ExpenseDetailCoordinatorState extends State<ExpenseDetailCoordinator> {
  late final StreamSubscription<ExpenseDetailAction> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = context.read<ExpenseDetailBloc>().actions.listen(_onAction);
  }

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }

  void _onAction(ExpenseDetailAction action) {
    if (!mounted) {
      return;
    }
    switch (action) {
      case GoBack():
        Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget._child;
  }
}
