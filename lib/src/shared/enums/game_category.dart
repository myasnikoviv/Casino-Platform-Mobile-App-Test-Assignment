import 'package:casino_platform_test/src/core/localization/app_localizations.dart';

/// Supported game categories.
enum GameCategory {
  /// Slot games category.
  slots('slots', 'categorySlots'),

  /// Live casino games category.
  live('live', 'categoryLive'),

  /// Table games category.
  table('table', 'categoryTable'),

  /// Jackpot games category.
  jackpot('jackpot', 'categoryJackpot');

  /// Creates [GameCategory] metadata.
  const GameCategory(this.rawValue, this.localizationKey);

  /// Raw value stored in JSON.
  final String rawValue;

  /// Localization key used in UI.
  final String localizationKey;

  /// Parses [raw] into [GameCategory].
  static GameCategory fromRaw(String raw) {
    return GameCategory.values.firstWhere(
      (GameCategory category) => category.rawValue == raw,
      orElse: () => GameCategory.slots,
    );
  }

  /// Returns localized label for category.
  String label(AppLocalizations l10n) => l10n.text(localizationKey);
}
