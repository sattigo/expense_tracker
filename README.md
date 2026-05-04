# expense_tracker

Demo application demonstrating Clean Architecture on Flutter. Two screens: transaction list and transaction detail. Local storage via SharedPreferences, no network layer.

## Stack

| Layer | Technology |
|---|---|
| State management | `BaseBloc<Event, State>` (custom, `core_bloc`) |
| DI | `get_it` |
| Routing | `go_router` (`AppRouter`, `AppGoRoute` from `core_navigation`) |
| Local storage | `shared_preferences` |
| Models / sealed classes | `freezed` + `json_serializable` |
| Code generation | `build_runner` |
| Failure | Sealed class from `core_failure` |
| Result | `Result<S, F>` sealed class from `core_result` |
| Tests | `flutter_test` + `bloc_test` + `mocktail` |
| Monorepo manager | `melos` |

## Structure

Melos monorepo. All packages live under `packages/`.

```
packages/
├── app/                    # Entry point, DI aggregator, MainRouter
├── core_bloc/              # BaseBloc<Event, State>
├── core_chain/             # ChainPipeline
├── core_expense_domain/    # Shared domain models for expenses
├── core_failure/           # Failure sealed class
├── core_result/            # Result<S, F> sealed class
├── core_navigation/        # AppRouter, AppGoRoute, named route constants
├── core_platform/          # Platform utilities
├── core_assets/
├── core_l10n/
├── feature_expenses_list/  # Expenses list screen
└── feature_expense_detail/ # Expense detail screen
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
flutter test packages/feature_expenses_list/test/unit/bloc/expense_bloc_test.dart
flutter test --name "emits loading"
```

## Data flow

```
Event -> BaseBloc -> UseCase -> Repository -> DataSource
  -> Result<Model, Failure>
  -> State update
```

## Requirements

- Flutter SDK `>=3.11.1 <4.0.0`
- Dart `>=3.11.1`
