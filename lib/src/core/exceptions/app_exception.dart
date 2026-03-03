import 'package:casino_platform_test/src/core/exceptions/exception_codes.dart';

/// Base exception contract for all known domain/infrastructure failures.
sealed class CPAppException implements Exception {
  /// Creates [CPAppException] with optional details.
  const CPAppException({this.message});

  /// Optional technical details.
  final String? message;
}

/// Indicates validation related user input errors.
class CPValidationException extends CPAppException {
  /// Creates [CPValidationException].
  const CPValidationException({required this.code, super.message});

  /// Strongly typed validation code.
  final CPValidationErrorCode code;
}

/// Indicates authentication failures.
class CPAuthException extends CPAppException {
  /// Creates [CPAuthException].
  const CPAuthException({required this.code, super.message});

  /// Strongly typed auth code.
  final CPAuthErrorCode code;
}

/// Indicates storage/read-write errors.
class CPStorageException extends CPAppException {
  /// Creates [CPStorageException].
  const CPStorageException({super.message});
}

/// Generic fallback exception.
class CPUnexpectedAppException extends CPAppException {
  /// Creates [CPUnexpectedAppException].
  const CPUnexpectedAppException({super.message});
}
