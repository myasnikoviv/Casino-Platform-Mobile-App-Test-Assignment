import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/exception_codes.dart';
import 'package:casino_platform_test/l10n/app_localizations.dart';

/// Converts exceptions into localized user-friendly UI messages.
class CPErrorMapper {
  /// Maps [exception] to a localization text.
  String mapToMessage(CPAppException exception, AppLocalizations l10n) {
    return switch (exception) {
      CPValidationException(:final code) => _fromValidationCode(code, l10n),
      CPAuthException(:final code) => _fromAuthCode(code, l10n),
      CPStorageException() => l10n.storageError,
      CPUnexpectedAppException() => l10n.unexpectedError,
    };
  }

  String _fromValidationCode(
      CPValidationErrorCode code, AppLocalizations l10n) {
    return switch (code) {
      CPValidationErrorCode.invalidEmail => l10n.invalidEmail,
      CPValidationErrorCode.passwordTooShort => l10n.passwordTooShort,
      CPValidationErrorCode.passwordsDoNotMatch => l10n.passwordsDoNotMatch,
      CPValidationErrorCode.emptyField => l10n.emptyField,
    };
  }

  String _fromAuthCode(CPAuthErrorCode code, AppLocalizations l10n) {
    return switch (code) {
      CPAuthErrorCode.invalidCredentials => l10n.invalidCredentials,
      CPAuthErrorCode.emailExists => l10n.emailExists,
      CPAuthErrorCode.authRequired => l10n.authRequired,
    };
  }
}
