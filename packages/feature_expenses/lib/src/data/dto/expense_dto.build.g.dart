// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_dto.build.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseDto _$ExpenseDtoFromJson(Map<String, dynamic> json) => _ExpenseDto(
  id: json['id'] as String,
  amount: (json['amount'] as num).toDouble(),
  title: json['title'] as String,
  date: json['date'] as String,
  category: json['category'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$ExpenseDtoToJson(_ExpenseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'title': instance.title,
      'date': instance.date,
      'category': instance.category,
      'type': instance.type,
    };
