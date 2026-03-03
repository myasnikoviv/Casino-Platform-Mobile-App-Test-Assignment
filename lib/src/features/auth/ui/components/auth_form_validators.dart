import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/exception_codes.dart';

/// Local form validators producing typed validation exceptions.
abstract final class CPAuthFormValidators {
  /// Validates full name input.
  static void validateName(String value) {
    if (value.trim().isEmpty) {
      throw const CPValidationException(
        code: CPValidationErrorCode.emptyField,
      );
    }
  }

  /// Validates email input format.
  static void validateEmail(String value) {
    if (value.trim().isEmpty) {
      throw const CPValidationException(
        code: CPValidationErrorCode.emptyField,
      );
    }
    final RegExp regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value.trim())) {
      throw const CPValidationException(
        code: CPValidationErrorCode.invalidEmail,
      );
    }
  }

  /// Validates password input complexity rule.
  static void validatePassword(String value) {
    if (value.isEmpty) {
      throw const CPValidationException(
        code: CPValidationErrorCode.emptyField,
      );
    }
    if (value.length < 8) {
      throw const CPValidationException(
        code: CPValidationErrorCode.passwordTooShort,
      );
    }
  }

  /// Validates equality for password confirmation.
  static void validatePasswordMatch(String value, String confirmValue) {
    if (value != confirmValue) {
      throw const CPValidationException(
        code: CPValidationErrorCode.passwordsDoNotMatch,
      );
    }
  }
}
