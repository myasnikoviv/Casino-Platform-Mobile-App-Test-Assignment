import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/l10n/app_localizations.dart';

/// Converts exceptions into localized user-friendly UI messages.
class CPErrorMapper {
  /// Maps [exception] to a localization text.
  String mapToMessage(CPAppException exception, AppLocalizations l10n) {
    return switch (exception) {
      CPValidationException(:final code) => _fromCode(code, l10n),
      CPAuthException(:final code) => _fromCode(code, l10n),
      CPStorageException() => l10n.storageError,
      CPUnexpectedAppException() => l10n.unexpectedError,
    };
  }

  String _fromCode(String code, AppLocalizations l10n) {
    return switch (code) {
      'invalidEmail' => l10n.invalidEmail,
      'passwordTooShort' => l10n.passwordTooShort,
      'passwordsDoNotMatch' => l10n.passwordsDoNotMatch,
      'emptyField' => l10n.emptyField,
      'invalidCredentials' => l10n.invalidCredentials,
      'emailExists' => l10n.emailExists,
      'authRequired' => l10n.authRequired,
      _ => l10n.unexpectedError,
    };
  }
}
