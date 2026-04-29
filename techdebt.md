# Tech Debt — Expense Tracker MVP

## Статус: APPROVED ✅ (итерация 3/3)

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
├── core_l10n/            # Локализация (en, ru)
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
8. `fix(feature_expenses): extract UI utils and remove domain displayName`

---

## Блокеры — все устранены ✅

### 1. ~~Хардкод UI-строк в domain-слое~~ → Исправлено (итерация 3)

- Удалены методы `displayName` из enum `ExpenseCategory` и `ExpenseType`
- Созданы UI extensions: `ExpenseCategoryDisplay`, `ExpenseTypeDisplay` с локализацией через `S.of(context)`
- Добавлены l10n ключи: `typeIncome`, `typeExpense`, `categoryFood`, `categoryTransport`, `categoryEntertainment`, `categoryShopping`, `categoryHealth`, `categoryOther`

### 2. ~~Дублирование логики (DRY)~~ → Исправлено (итерация 3)

- Создана утилита `lib/src/ui/utils/category_icon_mapper.dart` — функция `getCategoryIcon`
- Создана утилита `lib/src/ui/utils/date_formatter.dart` — функция `formatDate`
- Дублированные private-методы удалены из всех виджетов

---

## Замечания (не блокируют, можно улучшить позже)

1. **Формат даты** — `formatDate` использует хардкод `dd.MM.yyyy`. Можно добавить локализованное форматирование через `intl`.
2. **Валидация формы** — захардкожена в `AddExpenseBottomSheet`. При росте проекта вынести в отдельные валидаторы.
3. **Стиль GetIt** — в View используется `GetIt.I<Bloc>()`, в DI — `getIt`. Желательно унифицировать.
4. **Форматирование суммы** — `\$${expense.amount.toStringAsFixed(2)}` можно вынести в утилиту.

---

## Следующие шаги

1. ~~Передать блокеры разработчику~~ ✅
2. ~~Запустить финальное ревью (итерация 3/3)~~ ✅ APPROVED
3. Создать PR и смержить в main
