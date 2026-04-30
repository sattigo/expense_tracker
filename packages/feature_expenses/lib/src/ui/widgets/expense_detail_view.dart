import 'package:feature_expenses/src/ui/bloc/expense_detail_bloc.build.dart';
import 'package:feature_expenses/src/ui/widgets/expense_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ExpenseDetailView extends StatelessWidget {
  const ExpenseDetailView({required String expenseId, super.key}) : _expenseId = expenseId;

  final String _expenseId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ExpenseDetailBloc>()..add(ExpenseDetailEvent.load(_expenseId)),
      child: const ExpenseDetailWidget(),
    );
  }
}
