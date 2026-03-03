import 'package:casino_platform_test/l10n/app_localizations.dart';

/// Supported game categories.
enum CPGameCategory {
  /// Slot games category.
  slots('slots'),

  /// Live casino games category.
  live('live'),

  /// Table games category.
  table('table'),

  /// Jackpot games category.
  jackpot('jackpot');

  /// Creates [CPGameCategory] metadata.
  const CPGameCategory(this.rawValue);

  /// Raw value stored in JSON.
  final String rawValue;

  /// Parses [raw] into [CPGameCategory].
  static CPGameCategory fromRaw(String raw) {
    return CPGameCategory.values.firstWhere(
      (CPGameCategory category) => category.rawValue == raw,
      orElse: () => CPGameCategory.slots,
    );
  }

  /// Returns localized label for category.
  String label(AppLocalizations l10n) {
    return switch (this) {
      CPGameCategory.slots => l10n.categorySlots,
      CPGameCategory.live => l10n.categoryLive,
      CPGameCategory.table => l10n.categoryTable,
      CPGameCategory.jackpot => l10n.categoryJackpot,
    };
  }
}
