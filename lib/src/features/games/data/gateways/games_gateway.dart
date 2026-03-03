import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/constants/app_constants.dart';
import 'package:casino_platform_test/src/features/games/data/sources/games_json_data_source.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';

/// Gateway that serves games from data source with TTL caching policy.
class CPGamesGateway {
  /// Creates [CPGamesGateway].
  const CPGamesGateway(this._dataSource, this._cache);

  final CPGamesJsonDataSource _dataSource;
  final CPTtlCache<List<CPGameDto>> _cache;

  /// Returns game catalog from cache or source when cache expired.
  Future<List<CPGameDto>> getGames() async {
    final List<CPGameDto>? cached = _cache.get();
    if (cached != null) {
      return cached;
    }

    final List<CPGameDto> loaded = await _dataSource.loadGames();
    _cache.put(loaded, CPAppConstants.gamesCacheTtl);
    return loaded;
  }

  /// Clears in-memory catalog cache.
  void clearCache() {
    _cache.clear();
  }
}
