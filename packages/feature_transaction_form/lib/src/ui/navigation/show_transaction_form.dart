import 'package:feature_transaction_form/src/ui/widgets/view.dart';
import 'package:flutter/material.dart';

Future<void> showTransactionForm(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => const TransactionFormView(),
  );
}
