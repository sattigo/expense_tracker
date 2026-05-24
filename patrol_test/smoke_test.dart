import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'test_data.dart';

void main() {
  patrolTest(
    'app opens successfully',
        ($) async {
      WidgetsFlutterBinding.ensureInitialized();
      await setupServiceLocator();

      await $.pumpWidgetAndSettle(const ExpenseTrackerApp());

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
        WidgetsFlutterBinding.ensureInitialized();
        await setupServiceLocator();

        await $.pumpWidgetAndSettle(const ExpenseTrackerApp());

        await $('Add item').tap();
        await $.pumpAndTrySettle();

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
      WidgetsFlutterBinding.ensureInitialized();
      await setupServiceLocator();

      await $.pumpWidgetAndSettle(const ExpenseTrackerApp());

      await $('Add item').tap();
      await $.pumpAndTrySettle();

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
      WidgetsFlutterBinding.ensureInitialized();
      await setupServiceLocator();

      await $.pumpWidgetAndSettle(const ExpenseTrackerApp());

      await $('Add item').tap();
      await $.pumpAndTrySettle();

      expect($('Add Transaction'), findsOneWidget);

      await $(#titleField).tap();
      await $(#titleField).enterText('Egor Ola Amigos');
      await $.pumpAndTrySettle();

      expect($('Egor Ola Amigos'), findsOneWidget);

      await $(#amountField).tap();
      await $(#amountField).enterText('300');
      await $.pumpAndTrySettle();

      expect($('300'), findsOneWidget);

      await $(#dropdownTypeField).tap();
      await $('Expense').tap();
      await $.pumpAndTrySettle();

      expect($('Expense'), findsOneWidget);

      await $(#dropdownCategoryField).tap();
      await $('Health').tap();
      await $.pumpAndTrySettle();

      expect($('Health'), findsOneWidget);

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
}