# Tech Debt — Expense Tracker MVP

## Статус: CHANGES REQUIRED (итерация 2/3)

Ветка: `feature/expense-tracker-mvp`

---

## Задача

Рефакторинг counter app в Expense Tracker — приложение для учёта личных расходов.

**Требования:**
- Два экрана: список транзакций, детальный экран (только просмотр)
- Создание транзакции через bottom sheet
- Модель: id, amount, title, date, category (фиксированный список), type (income/expense)
- Локальное хранилище: SharedPreferences
- Архитектура: Clean Architecture, монорепо с пакетами

---

## Что сделано

Создана полная структура монорепо:

```
packages/
├── app/                  # Точка входа, DI, роутинг
├── core_bloc/            # BaseBloc<Event, State>
├── core_chain/           # ChainPipeline
├── core_failure/         # Failure sealed class
├── core_result/          # Result<S, F> sealed class
├── core_navigation/      # AppRouter, AppGoRoute, Routes
├── core_l10n/            # Локализация (en, ru) — 19 ключей
└── feature_expenses/     # Фича с полной Clean Architecture
```

**Коммиты в ветке:**
1. `feat(expenses): add expense tracker mvp`
2. `fix(feature_expenses): resolve code review issues`
3. `fix(feature_expenses): apply code review fixes`
4. `fix(feature_expenses): apply final code review fixes`
5. `fix(app): remove redundant MultiBlocProvider`
6. `fix(feature_expenses): add missing get_it dependency`
7. `fix(feature_expenses): replace hardcoded strings with l10n`

---

## Блокеры (не исправлены)

### 1. Хардкод UI-строк в domain-слое

**Файлы:**
- `/Users/sattigo/expense_tracker/packages/feature_expenses/lib/src/domain/models/expense_category.dart` (строки 9-18)
- `/Users/sattigo/expense_tracker/packages/feature_expenses/lib/src/domain/models/expense_type.dart` (строки 5-10)

**Проблема:** Методы `displayName` в enum `ExpenseCategory` и `ExpenseType` возвращают хардкод английские строки.

**Нарушения:**
- "Локализация только через S.of(context).* — никаких хардкод строк в UI"
- Clean Architecture: domain-слой не должен знать про UI-представление

**Решение:** Убрать `displayName` из domain-моделей, добавить extension на UI-слое с локализацией через `S.of(context)` или создать маппер в UI-слое.

---

### 2. Дублирование логики (нарушение DRY)

**Проблема:** Методы `_getCategoryIcon` и `_formatDate` дублируются в нескольких виджетах.

**Затронутые файлы:**
- `expense_list_widget.dart` (строки 111-120, 122-124)
- `expense_detail_widget.dart` (строки 89-98, 100-102)
- `add_expense_bottom_sheet.dart` (строки 134-136)

**Решение:** Вынести в отдельные утилиты:
- `lib/src/ui/utils/category_icon_mapper.dart`
- `lib/src/ui/utils/date_formatter.dart`

Или создать extension methods.

---

## Замечания (не блокируют)

1. **Стилистическое несоответствие GetIt** — в View используется `GetIt.I<Bloc>()`, в DI используется `getIt`. Желательно унифицировать.

2. **Форматирование суммы** — `\$${expense.amount.toStringAsFixed(2)}` в виджетах можно вынести в утилиту для единообразия.

---

## Следующие шаги

1. Передать блокеры разработчику
2. Запустить финальное ревью (итерация 3/3)
3. После APPROVED — мерж в main
