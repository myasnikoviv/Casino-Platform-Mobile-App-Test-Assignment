import 'package:casino_platform_test/src/core/localization/app_localizations.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/repositories/games_repository.dart';
import 'package:casino_platform_test/src/features/games/domain/entities/game_view_model.dart';

/// Service that adapts DTOs into UI-ready game view models.
class GamesService {
  /// Creates [GamesService].
  const GamesService(this._repository);

  final GamesRepository _repository;

  /// Returns localized game list for UI consumption.
  Future<List<GameViewModel>> getGames(AppLocalizations l10n) async {
    final List<GameDto> dtos = await _repository.getGames();
    return dtos.map((GameDto dto) => _adapt(dto, l10n)).toList();
  }

  /// Returns a single game by id from current data snapshot.
  Future<GameViewModel?> getGameById(
      String gameId, AppLocalizations l10n) async {
    final List<GameDto> dtos = await _repository.getGames();
    for (final GameDto dto in dtos) {
      if (dto.id == gameId) {
        return _adapt(dto, l10n);
      }
    }
    return null;
  }

  GameViewModel _adapt(GameDto dto, AppLocalizations l10n) {
    return GameViewModel(
      id: dto.id,
      name: dto.name,
      categoryLabel: dto.category.label(l10n),
      providerLabel: dto.provider,
      rtpLabel: '${dto.rtp.toStringAsFixed(2)}%',
      volatilityLabel: dto.volatility.label(l10n),
      description: dto.description,
      thumbnailUrl: dto.thumbnailUrl,
      headerUrl: dto.headerUrl,
    );
  }
}
