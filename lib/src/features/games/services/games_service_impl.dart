import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/core/exceptions/guarded_executor.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_gateway.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';

/// Service implementation that adapts DTOs into UI-ready game view models.
class CPGamesServiceImpl implements CPGamesService {
  /// Creates [CPGamesServiceImpl].
  const CPGamesServiceImpl(this._repository, this._executor);

  final CPGamesGateway _repository;
  final CPGuardedExecutor _executor;

  @override
  Future<List<CPGameViewModel>> getGames(AppLocalizations l10n) async {
    return _executor.run(() async {
      final List<CPGameDto> dtos = await _repository.getGames();
      return dtos.map((CPGameDto dto) => _adapt(dto, l10n)).toList();
    });
  }

  @override
  Future<CPGameViewModel?> getGameById(
      String gameId, AppLocalizations l10n) async {
    return _executor.run(() async {
      final List<CPGameDto> dtos = await _repository.getGames();
      for (final CPGameDto dto in dtos) {
        if (dto.id == gameId) {
          return _adapt(dto, l10n);
        }
      }
      return null;
    });
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
