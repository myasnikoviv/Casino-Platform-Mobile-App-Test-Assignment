import 'package:flutter/widgets.dart';
import 'package:casino_platform_test/l10n/app_localizations.dart';

/// Helper extension for concise access to localization resources.
extension CPBuildContextX on BuildContext {
  /// Returns app localization resources for this [BuildContext].
  AppLocalizations get l10n => AppLocalizations.of(this);
}
