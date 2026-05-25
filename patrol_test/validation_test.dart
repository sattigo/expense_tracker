import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'test_data.dart';

void main() {
  patrolTest(
    'Save by null title',
      ($)async {
      WidgetsFlutterBinding.ensureInitialized();
      await setupServiceLocator();

      await $.pumpWidgetAndSettle(const ExpenseTrackerApp());

      await $('Add item').tap();
      await $.pumpAndTrySettle();

      expect($('Add Transaction'), findsOneWidget);

      await $('Save').tap();
      await $.pumpAndTrySettle();

      expect($('Please enter a title'), findsOneWidget);

      }
  );

  patrolTest(
      'Save by null amount',
      ($)async {
      WidgetsFlutterBinding.ensureInitialized();
      await setupServiceLocator();

      await $.pumpWidgetAndSettle(const ExpenseTrackerApp());

      await $('Add item').tap();
      await $.pumpAndTrySettle();

      expect($('Add Transaction'), findsOneWidget);

      await $(#titleField).tap();
      await $(#titleField).enterText('I am text');
      await $.native.pressBack();
      await $.pumpAndTrySettle();

      expect($('I am text'), findsOneWidget);

      await $(#saveButton).tap();
      await $.pumpAndTrySettle();

      expect($('Please enter an amount'), findsOneWidget);

      }
  );

  patrolTest(
      'Max tittle length',
      ($)async{
          WidgetsFlutterBinding.ensureInitialized();
          await setupServiceLocator();

          await $.pumpWidgetAndSettle(const ExpenseTrackerApp());
          
          await $('Add item').tap();
          await $.pumpAndTrySettle();
          
          await $(#titleField).tap();
          await $(#titleField).enterText('Hello i am so big text for this title Hello i am so big text for this title');
          await $.pumpAndTrySettle();

          await $(#amountField).tap();
          await $(#amountField).enterText('40');
          await $.native.pressBack();
          await $.pumpAndTrySettle();

          await $(#saveButton).tap();
          await $.pumpAndTrySettle();

          expect($('Expense Tracker'), findsOneWidget);

          await $('List').tap();
          await $.pumpAndTrySettle();

          expect($('Hello i am so big text for this title Hello i am so big text for this title'), findsOneWidget);

      }
  );
}
