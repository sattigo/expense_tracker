sealed class AppFailure {
  const AppFailure(this.message);
  final String message;
}

final class StorageFailure extends AppFailure {
  const StorageFailure(super.message);
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message);
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure(super.message);
}
