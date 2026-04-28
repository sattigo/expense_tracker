// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'generated_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Expense Tracker';

  @override
  String get noExpensesYet => 'No expenses yet';

  @override
  String get noExpensesYetAddFirst => 'No expenses yet. Add your first expense!';

  @override
  String errorPrefix(String message) {
    return 'Error: $message';
  }

  @override
  String get retry => 'Retry';

  @override
  String get addTransaction => 'Add Transaction';

  @override
  String get title => 'Title';

  @override
  String get pleaseEnterTitle => 'Please enter a title';

  @override
  String get amount => 'Amount';

  @override
  String get pleaseEnterAmount => 'Please enter an amount';

  @override
  String get pleaseEnterValidNumber => 'Please enter a valid number';

  @override
  String get type => 'Type';

  @override
  String get category => 'Category';

  @override
  String get date => 'Date';

  @override
  String get save => 'Save';

  @override
  String get transactionDetails => 'Transaction Details';

  @override
  String get noData => 'No data';

  @override
  String get goBack => 'Go Back';

  @override
  String get transactionId => 'Transaction ID';
}
