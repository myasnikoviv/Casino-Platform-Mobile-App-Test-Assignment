import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/constants/app_constants.dart';
import 'package:casino_platform_test/src/core/exceptions/guarded_executor.dart';
import 'package:casino_platform_test/src/features/games/adapters/game_view_model_adapter.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_gateway.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';

/// Service implementation that adapts DTOs into UI-ready game view models.
class CPGamesServiceImpl implements CPGamesService {
  /// Creates [CPGamesServiceImpl].
  const CPGamesServiceImpl(
    this._gateway,
    this._cache,
    this._adapter,
    this._executor,
  );

  final CPGamesGateway _gateway;
  final CPTtlCache<List<CPGameDto>> _cache;
  final CPGameViewModelAdapter _adapter;
  final CPGuardedExecutor _executor;

  @override
  Future<List<CPGameViewModel>> getGames(AppLocalizations l10n) async {
    return _executor.run(() async {
      final List<CPGameDto>? cached = _safeGetCachedGames();
      if (cached != null) {
        return cached
            .map((CPGameDto dto) => _adapter.adapt(dto, l10n))
            .toList();
      }

      final List<CPGameDto> loaded = await _gateway.getGames();
      _cache.put(loaded, CPAppConstants.gamesCacheTtl);
      return loaded.map((CPGameDto dto) => _adapter.adapt(dto, l10n)).toList();
    });
  }

  @override
  Future<CPGameViewModel?> getGameById(
      String gameId, AppLocalizations l10n) async {
    return _executor.run(() async {
      final List<CPGameDto> dtos =
          _safeGetCachedGames() ?? await _gateway.getGames();
      for (final CPGameDto dto in dtos) {
        if (dto.id == gameId) {
          return _adapter.adapt(dto, l10n);
        }
      }
      return null;
    });
  }

  /// Reads cached games and self-heals malformed cache entries.
  List<CPGameDto>? _safeGetCachedGames() {
    try {
      return _cache.get();
    } catch (_) {
      _cache.clear();
      return null;
    }
  }
}
