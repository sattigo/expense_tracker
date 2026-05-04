import 'package:feature_transaction_form/src/ui/bloc/bloc.build.dart';
import 'package:feature_transaction_form/src/ui/widgets/transaction_form_coordinator.dart';
import 'package:feature_transaction_form/src/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TransactionFormView extends StatelessWidget {
  const TransactionFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormBloc>(
      create: (_) => GetIt.I<TransactionFormBloc>(),
      child: const TransactionFormCoordinator(child: TransactionFormWidget()),
    );
  }
}
