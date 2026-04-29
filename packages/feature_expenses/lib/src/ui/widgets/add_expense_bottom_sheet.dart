import 'package:core_bloc/core_bloc.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:feature_expenses/src/domain/models/expense.build.dart';
import 'package:feature_expenses/src/domain/models/expense_category.dart';
import 'package:feature_expenses/src/domain/models/expense_type.dart';
import 'package:feature_expenses/src/ui/bloc/expense_list_bloc.build.dart';
import 'package:feature_expenses/src/ui/utils/category_display.dart';
import 'package:feature_expenses/src/ui/utils/date_formatter.dart';
import 'package:feature_expenses/src/ui/utils/type_display.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddExpenseBottomSheet extends StatefulWidget {
  const AddExpenseBottomSheet({super.key});

  @override
  State<AddExpenseBottomSheet> createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends State<AddExpenseBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  ExpenseCategory _selectedCategory = ExpenseCategory.food;
  ExpenseType _selectedType = ExpenseType.expense;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.addTransaction, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: l10n.title, border: const OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterTitle;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: l10n.amount,
                  border: const OutlineInputBorder(),
                  prefixText: r'$ ',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterAmount;
                  }
                  if (double.tryParse(value) == null) {
                    return l10n.pleaseEnterValidNumber;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ExpenseType>(
                initialValue: _selectedType,
                decoration: InputDecoration(labelText: l10n.type, border: const OutlineInputBorder()),
                items: ExpenseType.values.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type.displayName(context)));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ExpenseCategory>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(labelText: l10n.category, border: const OutlineInputBorder()),
                items: ExpenseCategory.values.map((category) {
                  return DropdownMenuItem(value: category, child: Text(category.displayName(context)));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedCategory = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.date),
                subtitle: Text(formatDate(_selectedDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => _selectedDate = picked);
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onSave,
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: Text(l10n.save)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final expense = Expense(
        id: const Uuid().v4(),
        amount: double.parse(_amountController.text),
        title: _titleController.text,
        date: _selectedDate,
        category: _selectedCategory,
        type: _selectedType,
      );

      context.read<ExpenseListBloc>().add(ExpenseListEvent.add(expense));
      Navigator.of(context).pop();
    }
  }
}
