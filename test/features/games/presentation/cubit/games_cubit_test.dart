import 'package:bloc_test/bloc_test.dart';
import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/exceptions/guarded_executor.dart';
import 'package:casino_platform_test/src/features/games/adapters/game_view_model_adapter.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_state.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_api_gateway.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_gateway.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_local_gateway.dart';
import 'package:casino_platform_test/src/features/games/services/games_service_impl.dart';
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
        CPGamesServiceImpl(
          CPGamesGatewayImpl(
            _SuccessGamesSource(),
            const _NoopApiGateway(),
          ),
          CPMemoryTtlCache<List<CPGameDto>>(),
          const CPGameViewModelAdapter(),
          CPGuardedExecutor(),
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
        CPGamesServiceImpl(
          CPGamesGatewayImpl(
            _FailureGamesSource(),
            const _NoopApiGateway(),
          ),
          CPMemoryTtlCache<List<CPGameDto>>(),
          const CPGameViewModelAdapter(),
          CPGuardedExecutor(),
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

class _SuccessGamesSource implements CPGamesLocalGateway {
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

class _FailureGamesSource implements CPGamesLocalGateway {
  @override
  Future<List<CPGameDto>> loadGames() async {
    throw Exception('load failed');
  }
}

class _NoopApiGateway implements CPGamesApiGateway {
  const _NoopApiGateway();

  @override
  Future<List<CPGameDto>> fetchGames() async => const <CPGameDto>[];
}
