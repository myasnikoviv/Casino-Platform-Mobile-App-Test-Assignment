import 'package:casino_platform_test/src/core/errors/app_exception.dart';

/// Local form validators producing typed validation exceptions.
abstract final class AuthFormValidators {
  /// Validates full name input.
  static void validateName(String value) {
    if (value.trim().isEmpty) {
      throw const ValidationException(code: 'emptyField');
    }
  }

  /// Validates email input format.
  static void validateEmail(String value) {
    if (value.trim().isEmpty) {
      throw const ValidationException(code: 'emptyField');
    }
    final RegExp regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value.trim())) {
      throw const ValidationException(code: 'invalidEmail');
    }
  }

  /// Validates password input complexity rule.
  static void validatePassword(String value) {
    if (value.isEmpty) {
      throw const ValidationException(code: 'emptyField');
    }
    if (value.length < 8) {
      throw const ValidationException(code: 'passwordTooShort');
    }
  }

  /// Validates equality for password confirmation.
  static void validatePasswordMatch(String value, String confirmValue) {
    if (value != confirmValue) {
      throw const ValidationException(code: 'passwordsDoNotMatch');
    }
  }
}
