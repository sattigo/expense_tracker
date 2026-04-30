import 'package:feature_expenses_list/src/ui/bloc/bloc.build.dart';
import 'package:feature_expenses_list/src/ui/widgets/expense_list_coordinator.dart';
import 'package:feature_expenses_list/src/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ExpenseListBloc>()..add(const ExpenseListEvent.load()),
      child: const ExpenseListCoordinator(child: ExpenseListWidget()),
    );
  }
}
