// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'generated_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class SRu extends S {
  SRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Трекер расходов';

  @override
  String get noExpensesYet => 'Расходов пока нет';

  @override
  String get noExpensesYetAddFirst => 'Расходов пока нет. Добавьте первую транзакцию!';

  @override
  String errorPrefix(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get retry => 'Повторить';

  @override
  String get addTransaction => 'Добавить транзакцию';

  @override
  String get title => 'Название';

  @override
  String get pleaseEnterTitle => 'Введите название';

  @override
  String get amount => 'Сумма';

  @override
  String get pleaseEnterAmount => 'Введите сумму';

  @override
  String get pleaseEnterValidNumber => 'Введите корректное число';

  @override
  String get type => 'Тип';

  @override
  String get category => 'Категория';

  @override
  String get date => 'Дата';

  @override
  String get save => 'Сохранить';

  @override
  String get transactionDetails => 'Детали транзакции';

  @override
  String get noData => 'Нет данных';

  @override
  String get goBack => 'Назад';

  @override
  String get transactionId => 'ID транзакции';

  @override
  String get typeIncome => 'Income';

  @override
  String get typeExpense => 'Expense';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryOther => 'Other';
}
