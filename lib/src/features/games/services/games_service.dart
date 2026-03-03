import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';

/// Contract for games business operations.
abstract interface class CPGamesService {
  /// Returns localized game list for UI consumption.
  Future<List<CPGameViewModel>> getGames(AppLocalizations l10n);

  /// Returns a single game by id from current data snapshot.
  Future<CPGameViewModel?> getGameById(String gameId, AppLocalizations l10n);
}
