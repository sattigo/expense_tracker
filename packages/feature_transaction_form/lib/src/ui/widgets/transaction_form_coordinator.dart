import 'dart:async';

import 'package:feature_transaction_form/src/ui/bloc/bloc.build.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionFormCoordinator extends StatefulWidget {
  const TransactionFormCoordinator({required Widget child, super.key}) : _child = child;

  final Widget _child;

  @override
  State<TransactionFormCoordinator> createState() => _TransactionFormCoordinatorState();
}

class _TransactionFormCoordinatorState extends State<TransactionFormCoordinator> {
  late final StreamSubscription<TransactionFormAction> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = context.read<TransactionFormBloc>().actions.listen(_onAction);
  }

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }

  void _onAction(TransactionFormAction action) {
    if (!mounted) {
      return;
    }
    switch (action) {
      case CloseForm():
        Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget._child;
  }
}
