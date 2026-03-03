import 'package:casino_platform_test/src/core/localization/app_localizations.dart';
import 'package:flutter/widgets.dart';

/// Helper extension for concise access to localization resources.
extension CPBuildContextX on BuildContext {
  /// Returns app localization resources for this [BuildContext].
  CPLocalizations get l10n => CPLocalizations.of(this);
}
