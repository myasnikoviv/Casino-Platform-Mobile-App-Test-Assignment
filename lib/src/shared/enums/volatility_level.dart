import 'package:casino_platform_test/src/core/localization/app_localizations.dart';

/// Volatility levels for casino games.
enum CPVolatilityLevel {
  /// Low volatility profile.
  low('low', 'volatilityLow'),

  /// Medium volatility profile.
  medium('medium', 'volatilityMedium'),

  /// High volatility profile.
  high('high', 'volatilityHigh');

  /// Creates [CPVolatilityLevel].
  const CPVolatilityLevel(this.rawValue, this.localizationKey);

  /// Raw persistence value.
  final String rawValue;

  /// Localization key for UI label.
  final String localizationKey;

  /// Parses [raw] into enum.
  static CPVolatilityLevel fromRaw(String raw) {
    return CPVolatilityLevel.values.firstWhere(
      (CPVolatilityLevel level) => level.rawValue == raw,
      orElse: () => CPVolatilityLevel.medium,
    );
  }

  /// Returns localized label string.
  String label(CPLocalizations l10n) => l10n.text(localizationKey);
}
