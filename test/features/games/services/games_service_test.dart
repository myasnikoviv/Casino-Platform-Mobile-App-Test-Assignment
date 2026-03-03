import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/localization/app_localizations.dart';
import 'package:casino_platform_test/src/features/games/data/datasources/games_json_data_source.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/repositories/games_repository.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:casino_platform_test/src/shared/enums/game_category.dart';
import 'package:casino_platform_test/src/shared/enums/volatility_level.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GamesService', () {
    const AppLocalizations l10n = AppLocalizations(Locale('en'));

    test('adapts dto fields into localized view model', () async {
      final GamesService service = GamesService(
        GamesRepository(
          _StaticGamesSource(
            const <GameDto>[
              GameDto(
                id: 'g1',
                name: 'Sweet Bonanza',
                category: GameCategory.slots,
                provider: 'Pragmatic Play',
                rtp: 96.5,
                volatility: VolatilityLevel.high,
                description: 'Description',
                thumbnailUrl: 'thumb',
                headerUrl: 'header',
              ),
            ],
          ),
          TtlCache<List<GameDto>>(),
        ),
      );

      final games = await service.getGames(l10n);

      expect(games, hasLength(1));
      expect(games.first.categoryLabel, equals('Slots'));
      expect(games.first.rtpLabel, equals('96.50%'));
      expect(games.first.volatilityLabel, equals('High'));
    });

    test('returns null when game id is missing', () async {
      final GamesService service = GamesService(
        GamesRepository(
          _StaticGamesSource(const <GameDto>[]),
          TtlCache<List<GameDto>>(),
        ),
      );

      final result = await service.getGameById('missing', l10n);

      expect(result, isNull);
    });
  });
}

class _StaticGamesSource extends GamesJsonDataSource {
  _StaticGamesSource(this._games);

  final List<GameDto> _games;

  @override
  Future<List<GameDto>> loadGames() async => _games;
}
