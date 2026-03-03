import 'package:bloc_test/bloc_test.dart';
import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/sources/games_json_data_source.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_gateway.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:casino_platform_test/src/shared/enums/game_category.dart';
import 'package:casino_platform_test/src/shared/enums/volatility_level.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPGamesCubit', () {
    late AppLocalizations l10n;

    setUpAll(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    blocTest<CPGamesCubit, CPGamesState>(
      'emits success with mapped games',
      build: () => CPGamesCubit(
        CPGamesService(
          CPGamesGateway(
            _SuccessGamesSource(),
            CPTtlCache<List<CPGameDto>>(),
          ),
        ),
      ),
      act: (CPGamesCubit cubit) => cubit.loadGames(l10n),
      expect: () => <Matcher>[
        isA<CPGamesLoadingState>(),
        isA<CPGamesSuccessState>()
            .having((s) => s.games.length, 'games length', 1),
      ],
    );

    blocTest<CPGamesCubit, CPGamesState>(
      'emits error when service fails',
      build: () => CPGamesCubit(
        CPGamesService(
          CPGamesGateway(
            _FailureGamesSource(),
            CPTtlCache<List<CPGameDto>>(),
          ),
        ),
      ),
      act: (CPGamesCubit cubit) => cubit.loadGames(l10n),
      expect: () => <Matcher>[
        isA<CPGamesLoadingState>(),
        isA<CPGamesErrorState>()
            .having((s) => s.message, 'error', l10n.gamesLoadError),
      ],
    );
  });
}

class _SuccessGamesSource extends CPGamesJsonDataSource {
  @override
  Future<List<CPGameDto>> loadGames() async {
    return const <CPGameDto>[
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
    ];
  }
}

class _FailureGamesSource extends CPGamesJsonDataSource {
  @override
  Future<List<CPGameDto>> loadGames() async {
    throw Exception('load failed');
  }
}
