/// Base exception contract for all known domain/infrastructure failures.
sealed class AppException implements Exception {
  /// Creates [AppException] with optional details.
  const AppException({this.message});

  /// Optional technical details.
  final String? message;
}

/// Indicates validation related user input errors.
class ValidationException extends AppException {
  /// Creates [ValidationException].
  const ValidationException({required this.code, super.message});

  /// Localization key for user-facing validation feedback.
  final String code;
}

/// Indicates authentication failures.
class AuthException extends AppException {
  /// Creates [AuthException].
  const AuthException({required this.code, super.message});

  /// Localization key for user-facing auth feedback.
  final String code;
}

/// Indicates storage/read-write errors.
class StorageException extends AppException {
  /// Creates [StorageException].
  const StorageException({super.message});
}

/// Generic fallback exception.
class UnexpectedAppException extends AppException {
  /// Creates [UnexpectedAppException].
  const UnexpectedAppException({super.message});
}
