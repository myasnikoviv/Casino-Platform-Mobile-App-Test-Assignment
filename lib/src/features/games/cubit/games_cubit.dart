import 'package:casino_platform_test/src/core/localization/app_localizations.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit that loads and exposes games list state for UI screens.
class CPGamesCubit extends Cubit<CPGamesState> {
  /// Creates [CPGamesCubit].
  CPGamesCubit(this._gamesService) : super(CPGamesState.initial());

  final CPGamesService _gamesService;

  /// Loads games with localization-aware labels.
  Future<void> loadGames(CPLocalizations l10n) async {
    emit(state.copyWith(status: CPGamesStatus.loading));
    try {
      final games = await _gamesService.getGames(l10n);
      emit(state.copyWith(
          status: CPGamesStatus.success, games: games, errorMessage: null));
    } catch (_) {
      emit(
        state.copyWith(
          status: CPGamesStatus.error,
          errorMessage: l10n.text('gamesLoadError'),
        ),
      );
    }
  }
}
