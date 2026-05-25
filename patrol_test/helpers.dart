import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

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
  await $(#titleField).tap();
  await $(#titleField).enterText(title);
  await $.pumpAndTrySettle();
}

Future<void> enterAmount(PatrolIntegrationTester $, String amount) async {
  await $(#amountField).tap();
  await $(#amountField).enterText(amount);
  await $.pumpAndTrySettle();
}

Future<void> closeKeyboard(PatrolIntegrationTester $) async {
  await $.native.pressBack();
  await $.pumpAndTrySettle();
}
