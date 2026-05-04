import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.build.freezed.dart';

@freezed
sealed class Result<SUCCESS_TYPE, FAILURE_TYPE> with _$Result<SUCCESS_TYPE, FAILURE_TYPE> {
  const factory Result.success(SUCCESS_TYPE data) = Success<SUCCESS_TYPE, FAILURE_TYPE>;

  const factory Result.failure(FAILURE_TYPE error) = Error<SUCCESS_TYPE, FAILURE_TYPE>;
}

typedef ResultFuture<SUCCESS_TYPE, FAILURE_TYPE> = Future<Result<SUCCESS_TYPE, FAILURE_TYPE>>;
