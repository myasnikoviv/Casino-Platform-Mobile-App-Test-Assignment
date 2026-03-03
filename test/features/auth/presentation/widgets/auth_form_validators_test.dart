import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/exception_codes.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_form_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPAuthFormValidators', () {
    test('accepts valid sign-up inputs', () {
      expect(
          () => CPAuthFormValidators.validateName('Jane Doe'), returnsNormally);
      expect(
        () => CPAuthFormValidators.validateEmail('jane@example.com'),
        returnsNormally,
      );
      expect(() => CPAuthFormValidators.validatePassword('Password123!'),
          returnsNormally);
      expect(
        () =>
            CPAuthFormValidators.validatePasswordMatch('abc12345', 'abc12345'),
        returnsNormally,
      );
    });

    test('throws on invalid email format', () {
      expect(
        () => CPAuthFormValidators.validateEmail('not-an-email'),
        throwsA(
          isA<CPValidationException>().having(
            (CPValidationException e) => e.code,
            'code',
            CPValidationErrorCode.invalidEmail,
          ),
        ),
      );
    });

    test('throws on short password', () {
      expect(
        () => CPAuthFormValidators.validatePassword('1234'),
        throwsA(
          isA<CPValidationException>().having(
            (CPValidationException e) => e.code,
            'code',
            CPValidationErrorCode.passwordTooShort,
          ),
        ),
      );
    });

    test('throws on password mismatch', () {
      expect(
        () => CPAuthFormValidators.validatePasswordMatch(
            'Password1', 'Password2'),
        throwsA(
          isA<CPValidationException>().having(
            (CPValidationException e) => e.code,
            'code',
            CPValidationErrorCode.passwordsDoNotMatch,
          ),
        ),
      );
    });
  });
}
