import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/features/auth/presentation/widgets/auth_form_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthFormValidators', () {
    test('accepts valid sign-up inputs', () {
      expect(
          () => AuthFormValidators.validateName('Jane Doe'), returnsNormally);
      expect(
        () => AuthFormValidators.validateEmail('jane@example.com'),
        returnsNormally,
      );
      expect(() => AuthFormValidators.validatePassword('Password123!'),
          returnsNormally);
      expect(
        () => AuthFormValidators.validatePasswordMatch('abc12345', 'abc12345'),
        returnsNormally,
      );
    });

    test('throws on invalid email format', () {
      expect(
        () => AuthFormValidators.validateEmail('not-an-email'),
        throwsA(
          isA<ValidationException>().having(
            (ValidationException e) => e.code,
            'code',
            'invalidEmail',
          ),
        ),
      );
    });

    test('throws on short password', () {
      expect(
        () => AuthFormValidators.validatePassword('1234'),
        throwsA(
          isA<ValidationException>().having(
            (ValidationException e) => e.code,
            'code',
            'passwordTooShort',
          ),
        ),
      );
    });

    test('throws on password mismatch', () {
      expect(
        () =>
            AuthFormValidators.validatePasswordMatch('Password1', 'Password2'),
        throwsA(
          isA<ValidationException>().having(
            (ValidationException e) => e.code,
            'code',
            'passwordsDoNotMatch',
          ),
        ),
      );
    });
  });
}
