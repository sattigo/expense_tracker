sealed class Result<S, F> {
  const Result();
}

final class Success<S, F> extends Result<S, F> {
  const Success(this.data);
  final S data;
}

final class Failure<S, F> extends Result<S, F> {
  const Failure(this.failure);
  final F failure;
}
