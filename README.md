# expense_tracker

Demo application demonstrating Clean Architecture on Flutter. Screens: transaction list, transaction detail, add transaction form (modal), expense chart, home navigation shell. Local storage via SharedPreferences, no network layer.

## Stack

| Layer | Technology |
|---|---|
| State management | `BaseBloc<Event, State, Action>` (custom, `core_bloc`) |
| Side effects | `Action` stream via `emitAction()` in `BaseBloc` |
| Inter-feature events | `AppEventBus` from `core_event_bus` |
| DI | `get_it` |
| Routing | `go_router` (`AppRouter`, `AppGoRoute` from `core_navigation`) |
| Local storage | `shared_preferences` |
| Models / sealed classes | `freezed` + `json_serializable` |
| Code generation | `build_runner` (glob: `**.build.dart`) |
| Failure | Sealed class from `core_failure` |
| Result | `Result<S, F>` sealed class from `core_result` |
| Tests | `flutter_test` + `bloc_test` + `mocktail` |
| Monorepo manager | `melos` (`7.5.1`) |

## Structure

Melos monorepo. All packages live under `packages/`.

```
packages/
├── app/                    # Entry point, DI aggregator (service_locator.dart), MainRouter
├── core_bloc/              # BaseBloc<Event, State, Action>
├── core_chain/             # ChainTransformer, ChainValidator, Chainable, LinkableMixin
├── core_event_bus/         # AppEventBus, AppEvent (inter-feature events)
├── core_expense_domain/    # Shared domain + data for expenses (models, repository, datasource)
├── core_failure/           # Failure sealed class
├── core_result/            # Result<S, F> sealed class
├── core_navigation/        # AppRouter, AppGoRoute
├── core_assets/
├── core_l10n/              # Localization (l10n.yaml, ARB files)
├── core_platform/          # PlatformTypeService
├── feature_home/           # Navigation shell widget (home_shell_widget.dart)
├── feature_expenses_list/  # Expenses list screen
├── feature_expense_detail/ # Expense detail screen
├── feature_transaction_form/ # Add transaction form (modal bottom sheet)
└── feature_chart/          # Expense chart screen
```

## Setup

```bash
# Bootstrap workspace after clone or branch switch
dart run melos bootstrap
```

## Commands

```bash
# Format all .dart files (excluding *.g.dart, *.freezed.dart), line length 120
dart run melos run format

# Code generation (only in packages that depend on build_runner)
dart run melos run gen

# Static analysis
dart run melos run analyze

# Tests (only in packages with a test/ directory)
dart run melos run test

# Full reinit: pub cache clean -> melos clean -> melos bootstrap
dart run melos run reinit
```

Run a single test file directly:

```bash
flutter test packages/feature_expenses_list/test/unit/bloc/expense_list_bloc_test.dart
flutter test --name "emits loading"
```

## Data flow

```
Event -> BaseBloc -> UseCase -> Repository (core_expense_domain) -> DataSource
  -> Result<Model, Failure>
  -> State update
  -> Action (side effect) -> Coordinator / View
```

Inter-feature events (e.g. "transaction added") are passed via `AppEventBus`.

## Requirements

- Flutter SDK `>=3.11.1 <4.0.0`
- Dart `>=3.11.1`
