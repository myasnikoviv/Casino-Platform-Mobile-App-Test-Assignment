import 'package:casino_platform_test/src/core/localization/app_localizations.dart';

/// Supported game categories.
enum CPGameCategory {
  /// Slot games category.
  slots('slots', 'categorySlots'),

  /// Live casino games category.
  live('live', 'categoryLive'),

  /// Table games category.
  table('table', 'categoryTable'),

  /// Jackpot games category.
  jackpot('jackpot', 'categoryJackpot');

  /// Creates [CPGameCategory] metadata.
  const CPGameCategory(this.rawValue, this.localizationKey);

  /// Raw value stored in JSON.
  final String rawValue;

  /// Localization key used in UI.
  final String localizationKey;

  /// Parses [raw] into [CPGameCategory].
  static CPGameCategory fromRaw(String raw) {
    return CPGameCategory.values.firstWhere(
      (CPGameCategory category) => category.rawValue == raw,
      orElse: () => CPGameCategory.slots,
    );
  }

  /// Returns localized label for category.
  String label(CPLocalizations l10n) => l10n.text(localizationKey);
}
