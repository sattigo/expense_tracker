part of 'bloc.build.dart';

@freezed
sealed class ChartAction with _$ChartAction {
  const factory ChartAction.none() = _None;
}
