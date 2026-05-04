/// A simple FP-style Either implementation (fpdart-like)
/// Left = Failure, Right = Success
sealed class Either<L, R> {
  const Either();

  T fold<T>(
    T Function(L l) onLeft,
    T Function(R r) onRight,
  );
}

/// -------------------- LEFT (Failure) --------------------
class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  T fold<T>(
    T Function(L l) onLeft,
    T Function(R r) onRight,
  ) {
    return onLeft(value);
  }

  @override
  String toString() => 'Left($value)';
}

/// -------------------- RIGHT (Success) --------------------
class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  T fold<T>(
    T Function(L l) onLeft,
    T Function(R r) onRight,
  ) {
    return onRight(value);
  }

  @override
  String toString() => 'Right($value)';
}