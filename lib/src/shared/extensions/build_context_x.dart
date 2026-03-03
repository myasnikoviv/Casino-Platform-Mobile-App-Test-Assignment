import 'package:casino_platform_test/src/core/localization/app_localizations.dart';
import 'package:flutter/widgets.dart';

/// Helper extension for concise access to localization resources.
extension BuildContextX on BuildContext {
  /// Returns app localization resources for this [BuildContext].
  AppLocalizations get l10n => AppLocalizations.of(this);
}
