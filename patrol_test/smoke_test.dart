import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'test_data.dart';
import 'helpers.dart';
import 'package:feature_transaction_form/src/ui/widget_constants.dart';

void main() {
  patrolTest(
    'app opens successfully',
        ($) async {
      await launchApp($);

      expect($('Expense Tracker'), findsOneWidget);
      expect($('Add item'), findsOneWidget);
      expect($('List'), findsOneWidget);
      expect($('Chart'), findsOneWidget);
    },
  );

  patrolTest(
      'tap on Add item',
        ($)async{
          WidgetsFlutterBinding.ensureInitialized();
          await setupServiceLocator();

          await $.pumpWidgetAndSettle(const ExpenseTrackerApp());

          await $('Add item').tap();
          await $.pumpAndTrySettle();

          expect($('Add Transaction'), findsOneWidget);
          expect($('Save'), findsOneWidget);
        },
  );

  patrolTest(
    'select date',
      ($)async{
        await openAddTransactionScreen($);

        await $('Date').tap();
        await $.pumpAndTrySettle();

        expect($('Select date'), findsOneWidget);

        await $(today.day.toString()).tap();
        await $.pumpAndTrySettle();

        await $('OK').tap();
        await $.pumpAndTrySettle();

        expect($('Date'), findsOneWidget);

      },
  );

  patrolTest(
    'select date yesterday',
        ($)async{
      await openAddTransactionScreen($);

      await $('Date').tap();
      await $.pumpAndTrySettle();

      expect($('Select date'), findsOneWidget);

      await $(selectedDate.day.toString()).tap();
      await $.pumpAndTrySettle();

      await $('OK').tap();
      await $.pumpAndTrySettle();

      expect($('Date'), findsOneWidget);

    },
  );

  patrolTest(
    'Add item',
      ($)async{
      await openAddTransactionScreen($);

      expect($('Add Transaction'), findsOneWidget);

      await enterTitle($, TestData.transactionTitle);
      await $.pumpAndTrySettle();

      expect($('Egor Ola Amigos'), findsOneWidget);

      await enterAmount($, TestData.amount);
      await $.pumpAndTrySettle();

      expect($('500'), findsOneWidget);

      await $(const Key(TransactionFormKeys.dropdownTypeField)).tap();
      await $('Expense').tap();
      await $.pumpAndTrySettle();

      expect($('Expense'), findsOneWidget);

      await $(const Key(TransactionFormKeys.dropdownCategoryField)).tap();
      await $('Health').tap();
      await $.pumpAndTrySettle();

      expect($('Health'), findsOneWidget);

      await closeKeyboard($);

      await $('Date').tap();
      await $.pumpAndTrySettle();

      expect($('Select date'), findsOneWidget);

      await $(selectedDate.day.toString()).tap();
      await $.pumpAndTrySettle();

      await $('OK').tap();
      await $.pumpAndTrySettle();

      expect($('Date'), findsOneWidget);

      await $('Save').tap();

      expect($('Expense Tracker'), findsOneWidget);
      expect($('Egor Ola Amigos'), findsOneWidget);
  },
  );

  patrolTest(
    'Expense Details',
      ($)async {

      await openAddTransactionScreen($);

      await enterTitle($, TestData.transactionTitle);
      await enterAmount($, TestData.amount);

      await closeKeyboard($);

      await $('Save').tap();
      await $.pumpAndTrySettle();

      expect($(TestData.transactionTitle), findsOneWidget);

      await $(TestData.transactionTitle).tap();
      await $.pumpAndTrySettle();

      expect($('Transaction Details'), findsOneWidget);

      }
  );
}