# CLAUDE.md — Expense Tracker Demo

Этот файл читается Claude Code автоматически при каждом запуске сессии.
Все правила обязательны. Не отступай от них без явного указания.

**Этот файл — контекст проекта: стек, структура, соглашения по именованию, команды.**
Перед добавлением чего-либо сюда убедись: это описывает ЧТО за проект, а не КАК писать код.
Правила генерации кода, паттерны и примеры — в `.claude/skills/flutter_developer/SKILL.md`.

---

## Контекст проекта

Демо-приложение: список личных расходов (Expense Tracker).
Экраны: список транзакций, детальный экран транзакции, форма добавления транзакции (модал), график расходов, домашний shell (навигация).
Локальное хранилище: SharedPreferences. Сетевых запросов нет.
Цель кода: демонстрация Clean Architecture на Flutter. Код должен быть читаемым и педагогически прозрачным.

Проект — Melos монорепо с пакетной структурой. Новые фичи создаются отдельными пакетами в `packages/`.

---

## Стек

| Слой | Технология |
|---|---|
| State management | `BaseBloc<Event, State, Action>` из `core_bloc` |
| Side effects | `Action`-поток через `emitAction()` в `BaseBloc` |
| Inter-feature events | `AppEventBus` из `core_event_bus` |
| DI / Service locator | `get_it` |
| Роутинг | `go_router` (`AppRouter`, `AppGoRoute` из `core_navigation`) |
| Локальное хранилище | `shared_preferences` |
| Модели / sealed классы | `freezed` + `json_serializable` |
| Кодогенерация | `build_runner` (glob: `**.build.dart`) |
| Failure | sealed class из `core_failure` |
| Result | `Result<S, F>` sealed class из `core_result` |
| Тесты | `flutter_test` + `bloc_test` + `mocktail` |
| Менеджер монорепо | `melos` (`7.5.1`, в `dev_dependencies` корневого `pubspec.yaml`) |

---

## Структура монорепо

```
packages/
├── app/                    # Точка входа, DI агрегатор (service_locator.dart), MainRouter
├── core_bloc/              # BaseBloc<Event, State, Action>
├── core_chain/             # ChainTransformer, ChainValidator, Chainable, LinkableMixin
├── core_event_bus/         # AppEventBus, AppEvent (межфичевые события)
├── core_expense_domain/    # Общие domain + data для расходов (модели, репозиторий, datasource)
├── core_failure/           # Failure sealed class
├── core_result/            # Result<S, F> sealed class
├── core_navigation/        # AppRouter, AppGoRoute
├── core_assets/            # (пусто)
├── core_l10n/              # Локализация (l10n.yaml, ARB-файлы)
├── core_platform/          # PlatformTypeService
├── feature_home/           # Shell-виджет навигации (home_shell_widget.dart)
├── feature_expenses_list/  # Список транзакций
├── feature_expense_detail/ # Детальный экран транзакции
├── feature_transaction_form/ # Форма добавления (открывается как модал)
└── feature_chart/          # График расходов
```

---

## Архитектурное решение: core_expense_domain

Domain-модели, репозиторий и datasource вынесены в **общий пакет `core_expense_domain`**, а не дублируются в каждой фиче. Структура пакета:

```
core_expense_domain/lib/src/
├── domain/
│   ├── models/             # Expense, ExpenseCategory, ExpenseType
│   └── repositories/contract.dart  # ExpenseRepository (контракт)
└── data/
    ├── repositories/impl.dart      # ExpenseRepositoryImpl
    ├── data_sources/local/
    │   ├── contract.dart            # ExpenseLocalDataSource
    │   └── impl.dart                # ExpenseLocalDataSourceImpl
    └── dto/expense_dto.build.dart   # ExpenseDto (freezed + json_serializable)
```

Фиче-пакеты содержат только UseCase и UI-слой. Репозиторий и DataSource регистрируются в DI из `app/`.

---

## Структура feature-пакета

```
feature_expenses_list/
├── lib/
│   ├── feature_expenses_list.dart    # ТОЛЬКО экспортирует src/ui/widgets/view.dart
│   └── src/
│       ├── domain/
│       │   └── use_cases/get_expenses_use_case.dart
│       └── ui/
│           ├── bloc/
│           │   ├── bloc.build.dart   # extends BaseBloc<Event, State, Action> + part директивы
│           │   ├── event.dart        # part of 'bloc.build.dart'
│           │   ├── state.dart        # part of 'bloc.build.dart'
│           │   └── action.dart       # sealed class Action (side effects)
│           ├── widgets/
│           │   ├── view.dart                      # BlocProvider + подписка на Action
│           │   ├── widget.dart                    # BlocBuilder UI
│           │   └── <feature>_coordinator.dart     # Координатор навигации/side-effects
│           ├── utils/                             # Вспомогательные форматтеры/маперы
│           └── navigation/route.dart              # AppGoRoute (или show_<feature>.dart для модала)
└── test/
    ├── unit/bloc/<feature>_bloc_test.dart
    └── widget/<feature>_widget_test.dart
```

**Исключение для модалов:** `feature_transaction_form` использует `show_transaction_form.dart` вместо route.dart — открывается через `showModalBottomSheet`, а не go_router.

---

## DI-структура (app/)

```
app/lib/src/di/
├── service_locator.dart          # Точка входа: регистрирует SharedPreferences, PlatformTypeService, вызывает setupXxxDI()
├── core_event_bus_di.dart        # AppEventBus singleton
├── router_di.dart                # GoRouter
└── features/
    ├── expenses_di.dart          # DataSource → Repository → UseCases → Blocs (factory)
    ├── transaction_form_di.dart
    └── chart_di.dart
```

---

## Поток данных

```
Event → BaseBloc → UseCase → Repository (core_expense_domain) → DataSource
  → Result<Model, Failure>
  → обновление State
  → Action (side effect) → Coordinator / View
```

Межфичевые события (например, «транзакция добавлена») передаются через `AppEventBus`.

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
| BLoC | `ExpenseListBloc` |
| Event | `ExpenseListEvent` |
| State | `ExpenseListState` |
| Action (side effect) | `ExpenseListAction` |
| View (BlocProvider) | `ExpenseListView` |
| Widget (BlocBuilder UI) | `ExpenseListWidget` |
| Coordinator | `ExpenseListCoordinator` |
| Route (go_router) | `ExpenseListRoute` |
| Modal helper | `showTransactionForm()` |

Файлы с кодогенерацией: `<name>.build.dart`
Контракты: `contract.dart` / реализации: `impl.dart`
BLoC-файлы: `bloc.build.dart`, `event.dart`, `state.dart`, `action.dart` — всегда в папке `bloc/`

---

## Команды

Все командные операции над монорепо проходят через Melos. Конфигурация — в корневом `pubspec.yaml` под ключом `melos:`.

```bash
# Первичная инициализация воркспейса (после клона / смены ветки)
dart run melos bootstrap

# Форматирование всех .dart файлов (исключая *.g.dart и *.freezed.dart),
# длина строки 120 — стандарт проекта
dart run melos run format

# Кодогенерация: build_runner запускается ТОЛЬКО в пакетах,
# зависящих от build_runner (фильтр --depends-on)
dart run melos run gen

# Статический анализ всех пакетов
dart run melos run analyze

# Тесты — только в пакетах с папкой test/
dart run melos run test

# Полная переинициализация: pub cache clean → melos clean → melos bootstrap
dart run melos run reinit
```

Точечные запуски (без Melos), когда нужен один файл/тест:

```bash
flutter test packages/feature_expenses_list/test/unit/bloc/expense_list_bloc_test.dart
flutter test --name "emits loading"
```

Тесты в пакетах: `<package>/test/unit/` и `<package>/test/widget/`.

`pubspec.lock` отдельных пакетов в `packages/` не трекается (см. `.gitignore`) — трекается только корневой `pubspec.lock`.
