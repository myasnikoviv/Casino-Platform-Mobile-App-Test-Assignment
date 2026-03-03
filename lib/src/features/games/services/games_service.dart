import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_gateway.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';

/// Service that adapts DTOs into UI-ready game view models.
class CPGamesService {
  /// Creates [CPGamesService].
  const CPGamesService(this._repository);

  final CPGamesGateway _repository;

  /// Returns localized game list for UI consumption.
  Future<List<CPGameViewModel>> getGames(AppLocalizations l10n) async {
    final List<CPGameDto> dtos = await _repository.getGames();
    return dtos.map((CPGameDto dto) => _adapt(dto, l10n)).toList();
  }

  /// Returns a single game by id from current data snapshot.
  Future<CPGameViewModel?> getGameById(
      String gameId, AppLocalizations l10n) async {
    final List<CPGameDto> dtos = await _repository.getGames();
    for (final CPGameDto dto in dtos) {
      if (dto.id == gameId) {
        return _adapt(dto, l10n);
      }
    }
    return null;
  }

  CPGameViewModel _adapt(CPGameDto dto, AppLocalizations l10n) {
    return CPGameViewModel(
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
