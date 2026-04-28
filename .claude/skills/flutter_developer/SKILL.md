---
name: flutter_developer
description: Используй при создании новых Flutter фич, виджетов, BLoC, UseCase, репозиториев или любых изменениях в архитектуре пакетов проекта
---

# Flutter Feature Scaffold Skill

Ты — senior Flutter разработчик. При генерации кода **строго** следуй этому документу.
Никогда не отступай от описанных паттернов, структур и соглашений.

---

## 1. Стек

- **Flutter** + **Dart**
- **BLoC**: `flutter_bloc`, базовый класс `BaseBloc<Event, State>`
- **Freezed**: все Event, State, DTO, Domain модели
- **DI**: `get_it`
- **Сеть**: `DioClient` + `ChainPipeline`
- **Навигация**: `go_router` (обёрнут в `AppGoRoute`)
- **Локализация**: `core_l10n` → `S.of(context).*`
- **Результат операций**: `Result<S, F>` / `ResultFuture<S, F>`
- **Ошибки**: `Failure` (sealed class из `core_failure`)

---

## 2. Структура монорепо

```
packages/
├── app/                    # entry point, DI, MainRouter
├── core_bloc/              # BaseBloc<Event, State>
├── core_chain/             # ChainPipeline
├── core_dio/               # DioClient wrapper
├── core_failure/           # Failure sealed class
├── core_result/            # Result<S, F> sealed class
├── core_navigation/        # AppRouter, AppGoRoute
├── core_assets/
├── core_l10n/
├── core_platform/
└── feature_xxx/            # каждая фича — отдельный пакет
```

---

## 3. Структура feature-пакета

```
feature_xxx/
├── lib/
│   ├── feature_xxx.dart        # ТОЛЬКО: export 'src/ui/widgets/view.dart';
│   └── src/
│       ├── ui/
│       │   ├── bloc/
│       │   │   ├── bloc.build.dart   # extends BaseBloc + part директивы
│       │   │   ├── event.dart        # part of 'bloc.build.dart'
│       │   │   └── state.dart        # part of 'bloc.build.dart'
│       │   ├── widgets/
│       │   │   ├── view.dart         # BlocProvider
│       │   │   └── widget.dart       # BlocBuilder, основной UI
│       │   └── navigation/
│       │       └── route.dart
│       ├── domain/
│       │   ├── models/
│       │   ├── repositories/
│       │   │   └── contract.dart     # abstract interface class
│       │   └── use_cases/
│       │       └── fetch_xxx.dart
│       └── data/
│           ├── repositories/
│           │   └── impl.dart
│           ├── data_sources/
│           │   ├── remote/
│           │   │   ├── contract.dart
│           │   │   └── impl.dart
│           │   └── local/
│           │       ├── contract.dart
│           │       └── impl.dart
│           └── dto/
│               ├── models/
│               ├── transformers/
│               └── validators/
```

---

## 4. Архитектурный поток данных

```
BlocBuilder<Bloc, State>
    ↓
BaseBloc.on<Event>()
    ↓
UseCase.call() → ResultFuture<DomainModel, Failure>
    ↓
Repository [local cache check → remote]
    ↓
RemoteDataSource → DioClient.get(path)
    ↓
ChainPipeline
  .startWithValue(response.data)
  .transform(ApiTransformer)      // raw → DTO
  .validate(ApiValidator)
  .transform(DomainTransformer)   // DTO → Domain model
  .getResult()
    ↓
Result.success(data) | Result.failure(Failure)
```

---

## 5. Примеры кода

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

---

## 6. Правила генерации — ОБЯЗАТЕЛЬНО

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

### Никогда
- Не использовать `context.read<Bloc>()` внутри `builder` BlocBuilder
- Не делать логику в `View` — только провайдинг и композиция
- Не делать логику в `Widget` — только отображение состояния
- Не использовать `setState` — только BLoC
- Не импортировать между фичами напрямую — только через публичный экспорт
- Не использовать `Cubit` — только `BaseBloc`
- Не регистрировать `Bloc` через `registerSingleton` — только `registerFactory`
- Не добавлять DI регистрацию внутри feature-пакета — только в `app/lib/src/di/features/<xxx>_di.dart`
- Не возвращать `null` вместо `Failure` при ошибке

---

## 7. Соглашения по именованию

```
Пакет:           feature_xxx
Bloc:            XxxBloc
Event:           XxxEvent → конкретные: LoadXxx, AddXxx, DeleteXxx
State:           XxxState
View:            XxxView
Widget:          XxxWidget
UseCase:         FetchXxxUseCase / CreateXxxUseCase / DeleteXxxUseCase
Repository:      XxxRepository (contract) / XxxRepositoryImpl
DataSource:      XxxRemoteDataSource / XxxLocalDataSource
DTO:             XxxDto
DomainModel:     Xxx (чистый Dart-класс)

Файлы с кодогенерацией: <n>.build.dart
Контракты: contract.dart / реализации: impl.dart
BLoC-файлы: bloc.build.dart, event.dart, state.dart — всегда в папке bloc/
```

---

## 8. Форматирование и анализ

```bash
dart format --line-length 120 lib/
flutter analyze
```

Длина строки: **120 символов** — всегда, без исключений.

---

## 9. Догмы — ЖЕЛЕЗНЫЕ ПРАВИЛА

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

## 10. Тестирование

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

Тесты: `<package>/test/unit/` и `<package>/test/widget/`.
Widget-тесты проверяют поведение под состояния BLoC — не пиксельную вёрстку, не цвета, не навигацию.
