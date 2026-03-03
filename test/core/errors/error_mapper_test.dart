import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/exception_codes.dart';
import 'package:casino_platform_test/src/core/exceptions/error_mapper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPErrorMapper', () {
    late AppLocalizations l10n;
    final CPErrorMapper mapper = CPErrorMapper();

    setUpAll(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    test('maps validation code to localized message', () {
      final String message = mapper.mapToMessage(
        const CPValidationException(code: CPValidationErrorCode.invalidEmail),
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
