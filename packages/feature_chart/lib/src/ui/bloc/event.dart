part of 'bloc.build.dart';

@freezed
sealed class ChartEvent with _$ChartEvent {
  const factory ChartEvent.load() = LoadChart;
}
