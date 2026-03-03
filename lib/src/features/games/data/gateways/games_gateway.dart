import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/constants/app_constants.dart';
import 'package:casino_platform_test/src/features/games/data/sources/games_json_data_source.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';

/// Contract for games data retrieval.
abstract interface class CPGamesGateway {
  /// Returns game catalog.
  Future<List<CPGameDto>> getGames();

  /// Clears cached catalog.
  void clearCache();
}

/// Gateway that serves games from data source with TTL caching policy.
class CPGamesGatewayImpl implements CPGamesGateway {
  /// Creates [CPGamesGatewayImpl].
  const CPGamesGatewayImpl(this._dataSource, this._cache);

  final CPGamesJsonDataSource _dataSource;
  final CPTtlCache<List<CPGameDto>> _cache;

  /// Returns game catalog from cache or source when cache expired.
  @override
  Future<List<CPGameDto>> getGames() async {
    final List<CPGameDto>? cached = _cache.get();
    if (cached != null) {
      return cached;
    }

    final List<CPGameDto> loaded = await _dataSource.loadGames();
    _cache.put(loaded, CPAppConstants.gamesCacheTtl);
    return loaded;
  }

  /// Clears persisted catalog cache.
  @override
  void clearCache() {
    _cache.clear();
  }
}
