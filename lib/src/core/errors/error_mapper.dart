import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/localization/app_localizations.dart';

/// Converts exceptions into localized user-friendly UI messages.
class ErrorMapper {
  /// Maps [exception] to a localization text.
  String mapToMessage(AppException exception, AppLocalizations l10n) {
    return switch (exception) {
      ValidationException(:final code) => l10n.text(code),
      AuthException(:final code) => l10n.text(code),
      StorageException() => l10n.text('storageError'),
      UnexpectedAppException() => l10n.text('unexpectedError'),
    };
  }
}
