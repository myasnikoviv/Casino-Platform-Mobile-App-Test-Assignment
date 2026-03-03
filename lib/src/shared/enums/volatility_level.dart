import 'package:casino_platform_test/src/core/localization/app_localizations.dart';

/// Volatility levels for casino games.
enum VolatilityLevel {
  /// Low volatility profile.
  low('low', 'volatilityLow'),

  /// Medium volatility profile.
  medium('medium', 'volatilityMedium'),

  /// High volatility profile.
  high('high', 'volatilityHigh');

  /// Creates [VolatilityLevel].
  const VolatilityLevel(this.rawValue, this.localizationKey);

  /// Raw persistence value.
  final String rawValue;

  /// Localization key for UI label.
  final String localizationKey;

  /// Parses [raw] into enum.
  static VolatilityLevel fromRaw(String raw) {
    return VolatilityLevel.values.firstWhere(
      (VolatilityLevel level) => level.rawValue == raw,
      orElse: () => VolatilityLevel.medium,
    );
  }

  /// Returns localized label string.
  String label(AppLocalizations l10n) => l10n.text(localizationKey);
}
