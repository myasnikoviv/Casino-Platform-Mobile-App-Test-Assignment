import 'package:bloc_test/bloc_test.dart';
import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/localization/app_localizations.dart';
import 'package:casino_platform_test/src/features/games/data/datasources/games_json_data_source.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/repositories/games_repository.dart';
import 'package:casino_platform_test/src/features/games/presentation/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/presentation/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:casino_platform_test/src/shared/enums/game_category.dart';
import 'package:casino_platform_test/src/shared/enums/volatility_level.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GamesCubit', () {
    const AppLocalizations l10n = AppLocalizations(Locale('en'));

    blocTest<GamesCubit, GamesState>(
      'emits success with mapped games',
      build: () => GamesCubit(
        GamesService(
          GamesRepository(
            _SuccessGamesSource(),
            TtlCache<List<GameDto>>(),
          ),
        ),
      ),
      act: (GamesCubit cubit) => cubit.loadGames(l10n),
      expect: () => <Matcher>[
        isA<GamesState>()
            .having((GamesState s) => s.status, 'status', GamesStatus.loading),
        isA<GamesState>()
            .having((GamesState s) => s.status, 'status', GamesStatus.success)
            .having((GamesState s) => s.games.length, 'games length', 1),
      ],
    );

    blocTest<GamesCubit, GamesState>(
      'emits error when service fails',
      build: () => GamesCubit(
        GamesService(
          GamesRepository(
            _FailureGamesSource(),
            TtlCache<List<GameDto>>(),
          ),
        ),
      ),
      act: (GamesCubit cubit) => cubit.loadGames(l10n),
      expect: () => <Matcher>[
        isA<GamesState>()
            .having((GamesState s) => s.status, 'status', GamesStatus.loading),
        isA<GamesState>()
            .having((GamesState s) => s.status, 'status', GamesStatus.error)
            .having((GamesState s) => s.errorMessage, 'error',
                'Unable to load games right now.'),
      ],
    );
  });
}

class _SuccessGamesSource extends GamesJsonDataSource {
  @override
  Future<List<GameDto>> loadGames() async {
    return const <GameDto>[
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
    ];
  }
}

class _FailureGamesSource extends GamesJsonDataSource {
  @override
  Future<List<GameDto>> loadGames() async {
    throw Exception('load failed');
  }
}
