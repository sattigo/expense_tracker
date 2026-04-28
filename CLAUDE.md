# CLAUDE.md — Expense Tracker Demo

Этот файл читается Claude Code автоматически при каждом запуске сессии.
Все правила обязательны. Не отступай от них без явного указания.

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
| Pipeline | `ChainPipeline` из `core_chain` |
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
  → ChainPipeline (transform → validate → transform)
  → Result<Model, Failure>
  → обновление State
```

---

## Правила BLoC

- Event, State — всегда `part of 'bloc.build.dart'`, никогда отдельными самостоятельными файлами
- `@freezed sealed class` для Event
- `@freezed abstract class` для State
- Обработка Result — только через `switch`, не через `fold`

```dart
// Event
@freezed
sealed class ExpenseEvent with _$ExpenseEvent {
  const factory ExpenseEvent.load() = LoadExpenses;
  const factory ExpenseEvent.add(Expense expense) = AddExpense;
}

// State
@freezed
abstract class ExpenseState with _$ExpenseState {
  const factory ExpenseState.initial() = _Initial;
  const factory ExpenseState.loading() = _Loading;
  const factory ExpenseState.loaded(List<Expense> expenses) = _Loaded;
  const factory ExpenseState.error(String message) = _Error;
}

// Обработка Result — только switch
switch (result) {
  case Success(:final data):
    emit(ExpenseState.loaded(data));
  case Failure(:final failure):
    emit(ExpenseState.error(failure.message));
}
```

---

## Правила DI (get_it)

- BLoC → `registerFactory` (новый экземпляр на каждый вызов)
- Всё остальное (UseCase, Repository, DataSource) → `registerSingleton`
- DI регистрации — **только** в `app/lib/src/di/features/<xxx>_di.dart`
- Внутри feature-пакетов DI-регистраций нет

```dart
// ВЕРНО
getIt.registerFactory<ExpenseBloc>(
  () => ExpenseBloc(getIt<GetExpensesUseCase>()),
);
getIt.registerSingleton<GetExpensesUseCase>(
  GetExpensesUseCase(getIt<ExpenseRepository>()),
);

// НЕВЕРНО
getIt.registerSingleton<ExpenseBloc>(...);
getIt.registerLazySingleton<ExpenseBloc>(...);
```

---

## Правила Result / Failure

Используем `Result<S, F>` из `core_result`. Не используем `Either` из `dartz`. Не возвращаем `null` вместо `Failure`.

```dart
sealed class AppFailure {
  const AppFailure(this.message);
  final String message;
}

final class StorageFailure extends AppFailure {
  const StorageFailure(String message) : super(message);
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure(String message) : super(message);
}
```

---

## Правила роутинга (go_router)

- Все маршруты — именованные константы в `core_navigation`
- Передача данных между экранами — через `extra`, не query params
- `GoRouter` регистрируется в `get_it` как `registerLazySingleton`

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

---

## Кодогенерация

```bash
# Обрабатывает только **.build.dart файлы — это намеренно (конфиг build_runner)
dart run build_runner build --delete-conflicting-outputs

# После создания или изменения пакетов — регенерировать .gitignore секции
ignorium gen
# ВАЖНО: ignorium gen затирает строку 28 в packages/core_assets/.gitignore
# После каждого запуска вручную восстановить: !assets/icons/ на строке 28
```

Файлы с кодогенерацией именовать `<n>.build.dart` — build_runner glob матчит только `**.build.dart`.

---

## Форматирование и анализ

```bash
dart format --line-length 120 lib/
flutter analyze
```

Длина строки: **120 символов** — всегда, без исключений.

---

## Тесты

Стек: `flutter_test` + `bloc_test` + `mocktail`. Не использовать `mockito` — требует кодогена.

| Слой | Тестируем |
|---|---|
| BLoC | ✅ Всегда — переходы состояний |
| Утилиты (форматтеры, валидаторы) | ✅ Всегда |
| Виджеты | ✅ loading / error / success состояния |
| Repository / DataSource | ❌ Только I/O обёртки |

```bash
flutter test
flutter test test/unit/features/expenses/bloc/expense_bloc_test.dart
flutter test --name "emits loading"
```

Тесты в пакетах: `<package>/test/unit/` и `<package>/test/widget/`.
Widget-тесты проверяют поведение под состояния BLoC — не пиксельную вёрстку, не цвета, не навигацию.

---

## Публичное API пакетов

- Экспортировать только через `lib/<package_name>.dart`
- Импортировать из `src/` извне пакета — запрещено
- Версии зависимостей: точные (без `^`), кроме `ignorium`

---

## Что запрещено

- `setState` в бизнес-логике
- Прямой вызов SharedPreferences из BLoC или UseCase
- Импорт `dart:io` в domain-слое
- Вложенные `BlocBuilder` без явного `buildWhen`
- Возврат `null` вместо `Failure` при ошибке
- `fold` для обработки Result — только `switch`
- `mockito` в тестах — только `mocktail`
- Импорт из `src/` другого пакета напрямую
- `^` в версиях зависимостей (кроме `ignorium`)
- DI-регистрации внутри feature-пакетов
