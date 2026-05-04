part of 'bloc.build.dart';

@freezed
abstract class ChartState with _$ChartState {
  const factory ChartState.initial() = _Initial;
  const factory ChartState.loading() = _Loading;
  const factory ChartState.loaded(List<Expense> expenses) = _Loaded;
  const factory ChartState.error(String message) = _Error;
}
