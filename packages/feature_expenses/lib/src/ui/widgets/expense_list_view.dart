import 'package:core_bloc/core_bloc.dart';
import 'package:flutter/material.dart';
import '../bloc/expense_list_bloc.build.dart';
import 'expense_list_widget.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<ExpenseListBloc>()..add(const ExpenseListEvent.load()),
      child: const ExpenseListWidget(),
    );
  }
}
