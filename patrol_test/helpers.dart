import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:feature_transaction_form/src/ui/widget_constants.dart';



Future<void> launchApp(PatrolIntegrationTester $) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await $.pumpWidgetAndSettle(const ExpenseTrackerApp());
}

Future<void> openAddTransactionScreen(PatrolIntegrationTester $) async {
  await launchApp($);
  await $('Add item').tap();
  await $.pumpAndTrySettle();
}

Future<void> enterTitle(PatrolIntegrationTester $, String title) async {
  await $(const Key(TransactionFormKeys.titleField)).tap();
  await $(const Key(TransactionFormKeys.titleField)).enterText(title);
  await $.pumpAndTrySettle();
}

Future<void> enterAmount(PatrolIntegrationTester $, String amount) async {
  await $(const Key(TransactionFormKeys.amountField)).tap();
  await $(const Key(TransactionFormKeys.amountField)).enterText(amount);
  await $.pumpAndTrySettle();
}

Future<void> closeKeyboard(PatrolIntegrationTester $) async {
  await $.native.pressBack();
  await $.pumpAndTrySettle();
}
