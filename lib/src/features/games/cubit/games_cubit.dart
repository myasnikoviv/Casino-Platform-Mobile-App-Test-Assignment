import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit that loads and exposes games list state for UI screens.
class CPGamesCubit extends Cubit<CPGamesState> {
  /// Creates [CPGamesCubit].
  CPGamesCubit(this._gamesService) : super(const CPGamesLoadingState());

  final CPGamesService _gamesService;

  /// Loads games with localization-aware labels.
  Future<void> loadGames(AppLocalizations l10n) async {
    emit(const CPGamesLoadingState());
    try {
      final games = await _gamesService.getGames(l10n);
      emit(CPGamesSuccessState(games));
    } catch (_) {
      emit(CPGamesErrorState(message: l10n.gamesLoadError));
    }
  }
}
