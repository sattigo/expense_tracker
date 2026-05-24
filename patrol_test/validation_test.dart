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
}