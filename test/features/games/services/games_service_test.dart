import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/exceptions/guarded_executor.dart';
import 'package:casino_platform_test/src/features/games/adapters/game_view_model_adapter.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_gateway.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:casino_platform_test/src/features/games/services/games_service_impl.dart';
import 'package:casino_platform_test/src/shared/enums/game_category.dart';
import 'package:casino_platform_test/src/shared/enums/volatility_level.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPGamesService', () {
    late AppLocalizations l10n;

    setUpAll(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    test('adapts dto fields into localized view model', () async {
      final CPGamesService service = CPGamesServiceImpl(
        _StaticGamesGateway(
          const <CPGameDto>[
            CPGameDto(
              id: 'g1',
              name: 'Sweet Bonanza',
              category: CPGameCategory.slots,
              provider: 'Pragmatic Play',
              rtp: 96.5,
              volatility: CPVolatilityLevel.high,
              description: 'Description',
              thumbnailUrl: 'thumb',
              headerUrl: 'header',
            ),
          ],
        ),
        CPMemoryTtlCache<List<CPGameDto>>(),
        const CPGameViewModelAdapter(),
        CPGuardedExecutor(),
      );

      final games = await service.getGames(l10n);

      expect(games, hasLength(1));
      expect(games.first.categoryLabel, equals('Slots'));
      expect(games.first.rtpLabel, equals('96.50%'));
      expect(games.first.volatilityLabel, equals('High'));
    });

    test('returns null when game id is missing', () async {
      final CPGamesService service = CPGamesServiceImpl(
        _StaticGamesGateway(const <CPGameDto>[]),
        CPMemoryTtlCache<List<CPGameDto>>(),
        const CPGameViewModelAdapter(),
        CPGuardedExecutor(),
      );

      final result = await service.getGameById('missing', l10n);

      expect(result, isNull);
    });
  });
}

class _StaticGamesGateway implements CPGamesGateway {
  _StaticGamesGateway(this._games);

  final List<CPGameDto> _games;

  @override
  Future<List<CPGameDto>> getGames() async => _games;
}
