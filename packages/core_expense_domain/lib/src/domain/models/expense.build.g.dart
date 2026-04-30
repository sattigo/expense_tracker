// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.build.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Expense _$ExpenseFromJson(Map<String, dynamic> json) => _Expense(
  id: json['id'] as String,
  amount: (json['amount'] as num).toDouble(),
  title: json['title'] as String,
  date: DateTime.parse(json['date'] as String),
  category: $enumDecode(_$ExpenseCategoryEnumMap, json['category']),
  type: $enumDecode(_$ExpenseTypeEnumMap, json['type']),
);

Map<String, dynamic> _$ExpenseToJson(_Expense instance) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'title': instance.title,
  'date': instance.date.toIso8601String(),
  'category': _$ExpenseCategoryEnumMap[instance.category]!,
  'type': _$ExpenseTypeEnumMap[instance.type]!,
};

const _$ExpenseCategoryEnumMap = {
  ExpenseCategory.food: 'food',
  ExpenseCategory.transport: 'transport',
  ExpenseCategory.entertainment: 'entertainment',
  ExpenseCategory.shopping: 'shopping',
  ExpenseCategory.health: 'health',
  ExpenseCategory.other: 'other',
};

const _$ExpenseTypeEnumMap = {
  ExpenseType.income: 'income',
  ExpenseType.expense: 'expense',
};
