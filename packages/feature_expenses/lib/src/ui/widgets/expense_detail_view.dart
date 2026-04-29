import 'package:core_bloc/core_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../bloc/expense_detail_bloc.build.dart';
import 'expense_detail_widget.dart';

class ExpenseDetailView extends StatelessWidget {
  const ExpenseDetailView({super.key, required this.expenseId});

  final String expenseId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ExpenseDetailBloc>()..add(ExpenseDetailEvent.load(expenseId)),
      child: const ExpenseDetailWidget(),
    );
  }
}
