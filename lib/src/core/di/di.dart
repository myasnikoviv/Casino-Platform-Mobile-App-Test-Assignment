import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/errors/guarded_executor.dart';
import 'package:casino_platform_test/src/core/storage/hive_secure_box_factory.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_local_gateway.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service_impl.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/providers/games_json_data_source.dart';
import 'package:casino_platform_test/src/features/games/services/games_gateway.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

/// Dependency container with explicit register/resolve APIs.
class CPDI {
  static final GetIt _instance = GetIt.instance;
  static bool _initialized = false;

  /// Initializes all runtime dependencies.
  static Future<void> init() async {
    if (_initialized) {
      return;
    }

    registerDependency<CPSecureStorageService>(
      const CPSecureStorageService(FlutterSecureStorage()),
    );
    registerDependency<CPHiveSecureBoxFactory>(
      CPHiveSecureBoxFactory(resolveDependency<CPSecureStorageService>()),
    );
    registerDependency<CPAuthLocalGateway>(
      CPAuthLocalGateway(
        resolveDependency<CPHiveSecureBoxFactory>(),
        resolveDependency<CPSecureStorageService>(),
      ),
    );
    registerDependency<CPAuthService>(
      CPAuthServiceImpl(
        resolveDependency<CPAuthLocalGateway>(),
        LocalAuthentication(),
      ),
    );
    registerDependency<CPGuardedExecutor>(CPGuardedExecutor());

    registerDependency<CPGamesGateway>(
      CPGamesGateway(
        const CPGamesJsonDataSource(),
        CPTtlCache<List<CPGameDto>>(),
      ),
    );
    registerDependency<CPGamesService>(
      CPGamesService(resolveDependency<CPGamesGateway>()),
    );

    _initialized = true;
  }

  /// Registers singleton dependency instance.
  static void registerDependency<T extends Object>(T dependency) {
    if (_instance.isRegistered<T>()) {
      _instance.unregister<T>();
    }
    _instance.registerSingleton<T>(dependency);
  }

  /// Resolves dependency by type.
  static T resolveDependency<T extends Object>() => _instance.get<T>();

  /// Resolves async dependency by type.
  static Future<T> resolveAsyncDependency<T extends Object>() =>
      _instance.getAsync<T>();

  /// Instance-based resolver for convenience in widgets.
  T resolve<T extends Object>() => resolveDependency<T>();
}
