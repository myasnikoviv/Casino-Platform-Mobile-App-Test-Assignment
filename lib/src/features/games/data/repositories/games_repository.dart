import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/constants/app_constants.dart';
import 'package:casino_platform_test/src/features/games/data/datasources/games_json_data_source.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';

/// Repository that serves games from data source with TTL caching policy.
class GamesRepository {
  /// Creates [GamesRepository].
  const GamesRepository(this._dataSource, this._cache);

  final GamesJsonDataSource _dataSource;
  final TtlCache<List<GameDto>> _cache;

  /// Returns game catalog from cache or source when cache expired.
  Future<List<GameDto>> getGames() async {
    final List<GameDto>? cached = _cache.get();
    if (cached != null) {
      return cached;
    }

    final List<GameDto> loaded = await _dataSource.loadGames();
    _cache.put(loaded, AppConstants.gamesCacheTtl);
    return loaded;
  }

  /// Clears in-memory catalog cache.
  void clearCache() {
    _cache.clear();
  }
}
