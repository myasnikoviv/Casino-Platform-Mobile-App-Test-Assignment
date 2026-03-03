import 'package:casino_platform_test/src/core/errors/app_exception.dart';

/// Local form validators producing typed validation exceptions.
abstract final class CPAuthFormValidators {
  /// Validates full name input.
  static void validateName(String value) {
    if (value.trim().isEmpty) {
      throw const CPValidationException(code: 'emptyField');
    }
  }

  /// Validates email input format.
  static void validateEmail(String value) {
    if (value.trim().isEmpty) {
      throw const CPValidationException(code: 'emptyField');
    }
    final RegExp regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value.trim())) {
      throw const CPValidationException(code: 'invalidEmail');
    }
  }

  /// Validates password input complexity rule.
  static void validatePassword(String value) {
    if (value.isEmpty) {
      throw const CPValidationException(code: 'emptyField');
    }
    if (value.length < 8) {
      throw const CPValidationException(code: 'passwordTooShort');
    }
  }

  /// Validates equality for password confirmation.
  static void validatePasswordMatch(String value, String confirmValue) {
    if (value != confirmValue) {
      throw const CPValidationException(code: 'passwordsDoNotMatch');
    }
  }
}
