import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/errors/guarded_executor.dart';
import 'package:casino_platform_test/src/core/storage/hive_secure_box_factory.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:casino_platform_test/src/features/auth/data/repositories/auth_local_repository.dart';
import 'package:casino_platform_test/src/features/auth/domain/services/auth_service.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service_impl.dart';
import 'package:casino_platform_test/src/features/games/data/datasources/games_json_data_source.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/repositories/games_repository.dart';
import 'package:casino_platform_test/src/features/games/presentation/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';

/// Minimal service locator for dependency graph setup.
class ServiceLocator {
  late final SecureStorageService _secureStorageService;
  late final HiveSecureBoxFactory _secureBoxFactory;
  late final AuthLocalRepository _authLocalRepository;
  late final AuthService _authService;
  late final GamesRepository _gamesRepository;
  late final GamesService _gamesService;

  /// Shared global auth cubit.
  late final AuthCubit authCubit;

  /// Shared global games cubit.
  late final GamesCubit gamesCubit;

  /// Initializes dependency graph and bootstrap state.
  Future<void> initialize() async {
    await Hive.initFlutter();

    _secureStorageService = const SecureStorageService(FlutterSecureStorage());
    _secureBoxFactory = HiveSecureBoxFactory(_secureStorageService);
    _authLocalRepository =
        AuthLocalRepository(_secureBoxFactory, _secureStorageService);
    _authService = AuthServiceImpl(_authLocalRepository, LocalAuthentication());

    _gamesRepository = GamesRepository(
      const GamesJsonDataSource(),
      TtlCache<List<GameDto>>(),
    );
    _gamesService = GamesService(_gamesRepository);

    authCubit = AuthCubit(_authService, GuardedExecutor());
    gamesCubit = GamesCubit(_gamesService);

    await authCubit.initialize();
  }

  /// Disposes long-lived resources.
  void dispose() {
    authCubit.close();
    gamesCubit.close();
  }
}
