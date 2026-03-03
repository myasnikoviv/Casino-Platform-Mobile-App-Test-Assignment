import 'package:casino_platform_test/src/core/localization/app_localizations.dart';
import 'package:casino_platform_test/src/features/games/presentation/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit that loads and exposes games list state for UI screens.
class GamesCubit extends Cubit<GamesState> {
  /// Creates [GamesCubit].
  GamesCubit(this._gamesService) : super(GamesState.initial());

  final GamesService _gamesService;

  /// Loads games with localization-aware labels.
  Future<void> loadGames(AppLocalizations l10n) async {
    emit(state.copyWith(status: GamesStatus.loading));
    try {
      final games = await _gamesService.getGames(l10n);
      emit(state.copyWith(
          status: GamesStatus.success, games: games, errorMessage: null));
    } catch (_) {
      emit(
        state.copyWith(
          status: GamesStatus.error,
          errorMessage: l10n.text('gamesLoadError'),
        ),
      );
    }
  }
}
