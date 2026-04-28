import 'package:core_navigation/core_navigation.dart';
import 'package:flutter/material.dart';
import 'di/service_locator.dart';

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Expense Tracker',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      routerConfig: getIt<GoRouter>(),
    );
  }
}
