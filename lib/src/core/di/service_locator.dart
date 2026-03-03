import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/errors/guarded_executor.dart';
import 'package:casino_platform_test/src/core/storage/hive_secure_box_factory.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_local_repository.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service_impl.dart';
import 'package:casino_platform_test/src/features/games/providers/games_json_data_source.dart';
import 'package:casino_platform_test/src/features/games/entities/game_dto.dart';
import 'package:casino_platform_test/src/features/games/services/games_repository.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

/// Dependency registry aligned with production-style initialization flow.
class CPDI {
  static final GetIt _instance = GetIt.instance;

  /// Registers application dependencies.
  static Future<void> init() async {
    if (_instance.isRegistered<CPAuthService>()) {
      return;
    }

    _instance
      ..registerLazySingleton<CPSecureStorageService>(
        () => const CPSecureStorageService(FlutterSecureStorage()),
      )
      ..registerLazySingleton<CPHiveSecureBoxFactory>(
        () => CPHiveSecureBoxFactory(_instance.get<CPSecureStorageService>()),
      )
      ..registerLazySingleton<CPAuthLocalRepository>(
        () => CPAuthLocalRepository(
          _instance.get<CPHiveSecureBoxFactory>(),
          _instance.get<CPSecureStorageService>(),
        ),
      )
      ..registerLazySingleton<CPAuthService>(
        () => CPAuthServiceImpl(
          _instance.get<CPAuthLocalRepository>(),
          LocalAuthentication(),
        ),
      )
      ..registerFactory<CPGuardedExecutor>(CPGuardedExecutor.new)
      ..registerLazySingleton<CPGamesRepository>(
        () => CPGamesRepository(
          const CPGamesJsonDataSource(),
          CPTtlCache<List<CPGameDto>>(),
        ),
      )
      ..registerLazySingleton<CPGamesService>(
        () => CPGamesService(_instance.get<CPGamesRepository>()),
      );
  }

  /// Resolves dependency by type.
  T resolve<T extends Object>() => _instance.get<T>();
}
