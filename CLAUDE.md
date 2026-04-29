# CLAUDE.md — Expense Tracker Demo

Этот файл читается Claude Code автоматически при каждом запуске сессии.
Все правила обязательны. Не отступай от них без явного указания.

**Этот файл — контекст проекта: стек, структура, соглашения по именованию, команды.**
Перед добавлением чего-либо сюда убедись: это описывает ЧТО за проект, а не КАК писать код.
Правила генерации кода, паттерны и примеры — в `.claude/skills/flutter_developer/SKILL.md`.

---

## Контекст проекта

Демо-приложение: список личных расходов (Expense Tracker).
Два экрана: список транзакций → детальный экран транзакции.
Локальное хранилище: SharedPreferences. Сетевых запросов нет.
Цель кода: демонстрация Clean Architecture на Flutter. Код должен быть читаемым и педагогически прозрачным.

Целевое состояние проекта — Melos монорепо с пакетной структурой (в процессе перехода).
Новые фичи создаются отдельными пакетами в `packages/`.

---

## Стек

| Слой | Технология |
|---|---|
| State management | `BaseBloc<Event, State>` из `core_bloc` |
| DI / Service locator | `get_it` |
| Роутинг | `go_router` (`AppRouter`, `AppGoRoute` из `core_navigation`) |
| Локальное хранилище | `shared_preferences` |
| Модели / sealed классы | `freezed` + `json_serializable` |
| Кодогенерация | `build_runner` (glob: `**.build.dart`) |
| Failure | sealed class из `core_failure` |
| Result | `Result<S, F>` sealed class из `core_result` |
| Тесты | `flutter_test` + `bloc_test` + `mocktail` |

---

## Структура монорепо

```
packages/
├── app/                  # Точка входа, DI агрегатор, MainRouter
├── core_bloc/            # BaseBloc<Event, State>
├── core_chain/           # ChainPipeline (transform + validate)
├── core_failure/         # Failure sealed class
├── core_result/          # Result<S, F> sealed class
├── core_navigation/      # AppRouter, AppGoRoute
├── core_assets/
├── core_l10n/
├── core_platform/
└── feature_xxx/          # Один пакет на фичу
```

---

## Структура feature-пакета (строгая)

```
feature_expenses/
├── lib/
│   ├── feature_expenses.dart     # ТОЛЬКО экспортирует src/ui/widgets/view.dart
│   └── src/
│       ├── ui/
│       │   ├── bloc/
│       │   │   ├── bloc.build.dart   # extends BaseBloc + part директивы
│       │   │   ├── event.dart        # part of 'bloc.build.dart'
│       │   │   └── state.dart        # part of 'bloc.build.dart'
│       │   ├── widgets/
│       │   │   ├── view.dart         # BlocProvider
│       │   │   └── widget.dart       # BlocBuilder UI
│       │   └── navigation/route.dart
│       ├── domain/
│       │   ├── models/
│       │   ├── repositories/contract.dart
│       │   └── use_cases/fetch_expenses.dart
│       └── data/
│           ├── repositories/impl.dart
│           ├── data_sources/local/
│           └── dto/
```

---

## Поток данных

```
Event → BaseBloc → UseCase → Repository → DataSource
  → Result<Model, Failure>
  → обновление State
```

---

## Соглашения по именованию

| Тип | Пример |
|---|---|
| Entity / Domain model | `Expense` |
| DTO (data-слой) | `ExpenseDto` |
| UseCase | `GetExpensesUseCase` |
| Repository (контракт) | `ExpenseRepository` |
| Repository (реализация) | `ExpenseRepositoryImpl` |
| DataSource (контракт) | `ExpenseLocalDataSource` |
| DataSource (реализация) | `ExpenseLocalDataSourceImpl` |
| BLoC | `ExpenseBloc` |
| Event | `ExpenseEvent` |
| State | `ExpenseState` |
| View (BlocProvider) | `ExpenseListView` |
| Widget (BlocBuilder UI) | `ExpenseListWidget` |
| Route | `ExpenseListRoute` |

Файлы с кодогенерацией: `<n>.build.dart`
Контракты: `contract.dart` / реализации: `impl.dart`
BLoC-файлы: `bloc.build.dart`, `event.dart`, `state.dart` — всегда в папке `bloc/`

---

## Команды

```bash
# Кодогенерация (обрабатывает только **.build.dart — намеренно)
dart run build_runner build --delete-conflicting-outputs

# Форматирование (длина строки 120 — стандарт проекта)
dart format --line-length 120 lib/

# Анализ
flutter analyze

# Тесты
flutter test
flutter test test/unit/features/expenses/bloc/expense_bloc_test.dart
flutter test --name "emits loading"
```

Тесты в пакетах: `<package>/test/unit/` и `<package>/test/widget/`.
