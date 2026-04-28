import 'package:core_result/core_result.dart';

class ChainPipeline<T, F> {
  ChainPipeline(this._value);

  final Result<T, F> _value;

  Result<R, F> transform<R>(R Function(T data) transformer) {
    return switch (_value) {
      Success(:final data) => Success(transformer(data)),
      Failure(:final failure) => Failure(failure),
    };
  }

  Result<T, F> validate(Result<T, F> Function(T data) validator) {
    return switch (_value) {
      Success(:final data) => validator(data),
      Failure(:final failure) => Failure(failure),
    };
  }

  Result<T, F> get result => _value;
}
