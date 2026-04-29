---
name: flutter_developer
description: Используй при создании новых Flutter фич, виджетов, BLoC, UseCase, репозиториев или любых изменениях в архитектуре пакетов проекта
---

# Flutter Feature Scaffold Skill

Ты — senior Flutter разработчик. При генерации кода **строго** следуй этому документу.
Никогда не отступай от описанных паттернов, структур и соглашений.

**Этот файл — правила генерации кода: паттерны, примеры, запреты.**
Перед добавлением чего-либо сюда убедись: это описывает КАК писать код, а не ЧТО за проект.
Контекст проекта, стек, структура папок, соглашения по именованию — в `CLAUDE.md`.

---

## 1. Правила генерации — ОБЯЗАТЕЛЬНО

### Всегда
- `Event`, `State` — `part of 'bloc.build.dart'`, никогда отдельными файлами
- `@freezed sealed class` для Event
- `@freezed abstract class` для State
- Конструктор виджета: `const ClassName({super.key})`
- Приватные поля через именованный параметр: `({required Widget child}) : _child = child`
- Локализация **только** через `S.of(context).*` — никаких хардкод строк в UI
- `abstract interface class` для всех контрактов (data sources, repositories)
- UseCase принимает зависимости через `const` конструктор
- Обработка Result — только через `switch`, не через `fold`
- Импорты внутри пакета — только через `package:feature_xxx/...`, никаких `../../`
- Версии зависимостей в `pubspec.yaml` — точные, в двойных кавычках, без `^`: `shared_preferences: "2.2.2"`
- BLoC → `registerFactory`, всё остальное → `registerSingleton`
- DI регистрации — только в `app/lib/src/di/features/<xxx>_di.dart`
- Все маршруты — именованные константы в `core_navigation`
- Передача данных между экранами — через `extra`, не query params

### Никогда
- Не использовать `context.read<Bloc>()` внутри `builder` BlocBuilder
- Не делать логику в `View` — только провайдинг и композиция
- Не делать логику в `Widget` — только отображение состояния
- Не использовать `setState` — только BLoC
- Не импортировать между фичами напрямую — только через публичный экспорт
- Не использовать `Cubit` — только `BaseBloc`
- Не регистрировать `Bloc` через `registerSingleton` — только `registerFactory`
- Не добавлять DI регистрацию внутри feature-пакета
- Не возвращать `null` вместо `Failure` при ошибке
- Не использовать относительные импорты `../../` — только `package:feature_xxx/...`
- Не писать версии зависимостей с `^` или без кавычек — только `package: "x.y.z"`
- Не использовать `fold` для обработки Result — только `switch`
- Не использовать `mockito` — только `mocktail`
- Не импортировать из `src/` другого пакета напрямую
- Не использовать `print()` — только `debugPrint()` в debug-режиме

---

## 2. Примеры кода

### BLoC

```dart
// bloc.build.dart
part 'event.dart';
part 'state.dart';

class ExpenseBloc extends BaseBloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc({required GetExpensesUseCase getExpensesUseCase})
      : _getExpensesUseCase = getExpensesUseCase,
        super(const ExpenseState.initial()) {
    on<LoadExpenses>(_onLoadExpenses);
  }

  final GetExpensesUseCase _getExpensesUseCase;

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(const ExpenseState.loading());
    final result = await _getExpensesUseCase();
    switch (result) {
      case Success(:final data):
        emit(ExpenseState.loaded(data));
      case Failure(:final failure):
        emit(ExpenseState.error(failure.message));
    }
  }
}
```

### Event / State

```dart
// event.dart
part of 'bloc.build.dart';

@freezed
sealed class ExpenseEvent with _$ExpenseEvent {
  const factory ExpenseEvent.load() = LoadExpenses;
  const factory ExpenseEvent.add(Expense expense) = AddExpense;
}

// state.dart
part of 'bloc.build.dart';

@freezed
abstract class ExpenseState with _$ExpenseState {
  const factory ExpenseState.initial() = _Initial;
  const factory ExpenseState.loading() = _Loading;
  const factory ExpenseState.loaded(List<Expense> expenses) = _Loaded;
  const factory ExpenseState.error(String message) = _Error;
}
```

### View / Widget

```dart
// view.dart — только провайдинг
class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExpenseBloc>(
      create: (_) => getIt<ExpenseBloc>()..add(const ExpenseEvent.load()),
      child: const ExpenseListWidget(),
    );
  }
}

// widget.dart — только отображение состояния
class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) => switch (state) {
        _Initial() => const SizedBox.shrink(),
        _Loading() => const CircularProgressIndicator(),
        _Loaded(:final expenses) => _ExpenseList(expenses: expenses),
        _Error(:final message) => Text(message),
      },
    );
  }
}
```

### UseCase

```dart
class GetExpensesUseCase {
  const GetExpensesUseCase({required ExpenseRepository repository})
      : _repository = repository;

  final ExpenseRepository _repository;

  ResultFuture<List<Expense>, AppFailure> call() => _repository.getExpenses();
}
```

### Repository

```dart
// contract.dart
abstract interface class ExpenseRepository {
  ResultFuture<List<Expense>, AppFailure> getExpenses();
}

// impl.dart
final class ExpenseRepositoryImpl implements ExpenseRepository {
  const ExpenseRepositoryImpl({required ExpenseLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  final ExpenseLocalDataSource _localDataSource;

  @override
  ResultFuture<List<Expense>, AppFailure> getExpenses() async {
    try {
      final expenses = await _localDataSource.getExpenses();
      return Result.success(expenses);
    } catch (e) {
      return Result.failure(StorageFailure(e.toString()));
    }
  }
}
```

### DI

```dart
// app/lib/src/di/features/expenses_di.dart
abstract final class ExpensesDi {
  static void register(GetIt getIt) {
    getIt
      ..registerSingleton<ExpenseLocalDataSource>(ExpenseLocalDataSourceImpl())
      ..registerSingleton<ExpenseRepository>(
        ExpenseRepositoryImpl(localDataSource: getIt<ExpenseLocalDataSource>()),
      )
      ..registerSingleton<GetExpensesUseCase>(
        GetExpensesUseCase(repository: getIt<ExpenseRepository>()),
      )
      ..registerFactory<ExpenseBloc>(
        () => ExpenseBloc(getExpensesUseCase: getIt<GetExpensesUseCase>()),
      );
  }
}
```

### Result / Failure

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

// Обработка — только switch
switch (result) {
  case Success(:final data):
    emit(ExpenseState.loaded(data));
  case Failure(:final failure):
    emit(ExpenseState.error(failure.message));
}
```

---

## 3. Догмы — ЖЕЛЕЗНЫЕ ПРАВИЛА

Нарушение любого из правил допустимо **только с явного разрешения разработчика**.

После завершения каждой задачи пройди этот чек-лист. Если хотя бы один пункт не выполнен — пересмотри решение.

- [ ] **Код стал лучше** — читаемость, гибкость и понятность не ухудшились. Ни один затронутый участок не стал хуже.
- [ ] **Clean Architecture** — слои соблюдены: UI → Domain → Data. Обратных зависимостей нет.
- [ ] **SOLID** — каждый класс имеет одну причину меняться, зависимости инжектируются через конструктор, контракты используются везде, где есть реализация.
- [ ] **KISS** — решение настолько простое, насколько позволяет задача. Нет избыточной абстракции, нет "на будущее".
- [ ] **DRY** — нет дублирования логики. Одинаковое поведение в одном месте.
- [ ] **Зависимости направлены внутрь** — Domain не импортирует Flutter, get_it, Dio или что-либо из Data/UI.
- [ ] **Слои не пересекаются** — UI не знает про DTO, Data не знает про виджеты. Взаимодействие только через контракты.
- [ ] **Явное лучше неявного** — все зависимости передаются через конструктор. Никаких скрытых обращений к глобальному состоянию.
- [ ] **Публичное API минимально** — из пакета экспортируется только то, что нужно потребителю.

---

## 4. Тестирование

**Правило:** тронул код — написал тесты. Минимум: покрыт тот слой, который был изменён.

| Слой | Тестируем |
|---|---|
| BLoC | ✅ Всегда — переходы состояний |
| Утилиты (форматтеры, валидаторы) | ✅ Всегда |
| Виджеты | ✅ loading / error / success состояния |
| Repository / DataSource | ❌ Только I/O-обёртка |

Стек: `flutter_test` + `bloc_test` + `mocktail`. Не использовать `mockito`.

```dart
// Unit-тест BLoC
blocTest<ExpenseBloc, ExpenseState>(
  'emits [loading, loaded] when fetch succeeds',
  build: () {
    when(() => repository.getExpenses()).thenAnswer(
      (_) async => Result.success([expense]),
    );
    return ExpenseBloc(getExpensesUseCase: GetExpensesUseCase(repository: repository));
  },
  act: (bloc) => bloc.add(const ExpenseEvent.load()),
  expect: () => [
    isA<_Loading>(),
    isA<_Loaded>().having((s) => s.expenses, 'expenses', [expense]),
  ],
);

// Widget-тест
testWidgets('shows loader on loading state', (tester) async {
  when(() => bloc.state).thenReturn(const ExpenseState.loading());
  await tester.pumpWidget(
    BlocProvider<ExpenseBloc>.value(
      value: bloc,
      child: const MaterialApp(home: ExpenseListWidget()),
    ),
  );
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

Widget-тесты проверяют поведение под состояния BLoC — не пиксельную вёрстку, не цвета, не навигацию.
