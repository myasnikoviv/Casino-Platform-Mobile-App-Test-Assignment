import 'package:casino_platform_test/l10n/app_localizations.dart';

/// Volatility levels for casino games.
enum CPVolatilityLevel {
  /// Low volatility profile.
  low('low'),

  /// Medium volatility profile.
  medium('medium'),

  /// High volatility profile.
  high('high');

  /// Creates [CPVolatilityLevel].
  const CPVolatilityLevel(this.rawValue);

  /// Raw persistence value.
  final String rawValue;

  /// Parses [raw] into enum.
  static CPVolatilityLevel fromRaw(String raw) {
    return CPVolatilityLevel.values.firstWhere(
      (CPVolatilityLevel level) => level.rawValue == raw,
      orElse: () => CPVolatilityLevel.medium,
    );
  }

  /// Returns localized label string.
  String label(AppLocalizations l10n) {
    return switch (this) {
      CPVolatilityLevel.low => l10n.volatilityLow,
      CPVolatilityLevel.medium => l10n.volatilityMedium,
      CPVolatilityLevel.high => l10n.volatilityHigh,
    };
  }
}
