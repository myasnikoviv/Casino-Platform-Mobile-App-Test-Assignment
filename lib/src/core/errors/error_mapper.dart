import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/localization/app_localizations.dart';

/// Converts exceptions into localized user-friendly UI messages.
class CPErrorMapper {
  /// Maps [exception] to a localization text.
  String mapToMessage(CPAppException exception, CPLocalizations l10n) {
    return switch (exception) {
      CPValidationException(:final code) => l10n.text(code),
      CPAuthException(:final code) => l10n.text(code),
      CPStorageException() => l10n.text('storageError'),
      CPUnexpectedAppException() => l10n.text('unexpectedError'),
    };
  }
}
