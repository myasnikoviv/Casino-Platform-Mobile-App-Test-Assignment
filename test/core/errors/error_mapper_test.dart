import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/errors/error_mapper.dart';
import 'package:casino_platform_test/src/core/localization/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPErrorMapper', () {
    const CPLocalizations l10n = CPLocalizations(Locale('en'));
    final CPErrorMapper mapper = CPErrorMapper();

    test('maps validation code to localized message', () {
      final String message = mapper.mapToMessage(
        const CPValidationException(code: 'invalidEmail'),
        l10n,
      );

      expect(message, equals('Enter a valid email address.'));
    });

    test('maps storage exception to fallback localized message', () {
      final String message =
          mapper.mapToMessage(const CPStorageException(), l10n);
      expect(message, equals('Storage error occurred. Please retry.'));
    });
  });
}
