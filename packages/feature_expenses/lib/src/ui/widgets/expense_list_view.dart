import 'package:core_bloc/core_bloc.dart';
import 'package:feature_expenses/src/ui/bloc/expense_list_bloc.build.dart';
import 'package:feature_expenses/src/ui/widgets/expense_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ExpenseListBloc>()..add(const ExpenseListEvent.load()),
      child: const ExpenseListWidget(),
    );
  }
}
