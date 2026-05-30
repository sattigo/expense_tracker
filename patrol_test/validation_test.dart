import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'test_data.dart';
import 'helpers.dart';
import 'package:feature_transaction_form/src/ui/widget_constants.dart';

void main() {
  patrolTest(
    'Save by null title',
      ($)async {
      await openAddTransactionScreen($);

      expect($('Add Transaction'), findsOneWidget);

      await $('Save').tap();
      await $.pumpAndTrySettle();

      expect($('Please enter a title'), findsOneWidget);

      }
  );

  patrolTest(
      'Save by null amount',
      ($)async {
      await openAddTransactionScreen($);

      expect($('Add Transaction'), findsOneWidget);

      await enterTitle($, TestData.transactionTitle);
      await $.native.pressBack();
      await $.pumpAndTrySettle();

      expect($(TestData.transactionTitle), findsOneWidget);

      await $(const Key(TransactionFormKeys.saveButton)).tap();
      await $.pumpAndTrySettle();

      expect($('Please enter an amount'), findsOneWidget);

      }
  );

  patrolTest(
      'Max tittle length',
      ($)async{
          await openAddTransactionScreen($);
          
          await enterTitle($, 'Hello i am so big text for this title Hello i am so big text for this title');

          await enterAmount($, TestData.amount);

          await closeKeyboard($);

          await $(const Key(TransactionFormKeys.saveButton)).tap();
          await $.pumpAndTrySettle();


          expect($('Expense Tracker'), findsOneWidget);

          await $('List').tap();
          await $.pumpAndTrySettle();

          expect($('Hello i am so big text for this title Hello i am so big text for this title'), findsOneWidget);

      }
  );
}
