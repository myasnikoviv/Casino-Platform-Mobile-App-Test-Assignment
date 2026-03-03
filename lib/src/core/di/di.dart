import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/exceptions/guarded_executor.dart';
import 'package:casino_platform_test/src/core/storage/hive_secure_box_factory.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/auth_local_gateway.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service_impl.dart';
import 'package:casino_platform_test/src/core/constants/app_constants.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_gateway.dart';
import 'package:casino_platform_test/src/features/games/data/sources/games_json_data_source.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';

/// Dependency container with explicit register/resolve APIs.
class CPDI {
  static final Map<Type, Object> _dependencies = <Type, Object>{};
  static bool _initialized = false;

  /// Initializes all runtime dependencies.
  static Future<void> init() async {
    if (_initialized) {
      return;
    }

    registerDependency<CPSecureStorageService>(
      const CPSecureStorageServiceImpl(FlutterSecureStorage()),
    );
    registerDependency<CPSecureBoxFactory>(
      CPHiveSecureBoxFactory(resolveDependency<CPSecureStorageService>()),
    );
    registerDependency<CPAuthLocalGateway>(
      CPAuthLocalGatewayImpl(
        resolveDependency<CPSecureBoxFactory>(),
        resolveDependency<CPSecureStorageService>(),
      ),
    );
    registerDependency<CPGuardedExecutor>(CPGuardedExecutor());
    registerDependency<CPAuthService>(
      CPAuthServiceImpl(
        resolveDependency<CPAuthLocalGateway>(),
        LocalAuthentication(),
        resolveDependency<CPGuardedExecutor>(),
      ),
    );
    registerDependency<CPAuthCubit>(
      CPAuthCubit(resolveDependency<CPAuthService>()),
    );

    final Box<dynamic> cacheBox =
        await Hive.openBox<dynamic>(CPAppConstants.cacheBoxName);
    registerDependency<CPGamesGateway>(
      CPGamesGatewayImpl(
        const CPGamesJsonDataSource(),
        CPHiveTtlCache<List<CPGameDto>>(
          box: cacheBox,
          cacheKey: CPAppConstants.gamesCacheKey,
          encode: (List<CPGameDto> value) {
            return value.map((CPGameDto dto) => dto.toJson()).toList();
          },
          decode: (Object? raw) {
            final List<dynamic> data = raw as List<dynamic>;
            return data
                .map((dynamic item) =>
                    CPGameDto.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        ),
      ),
    );
    registerDependency<CPGamesService>(
      CPGamesServiceImpl(
        resolveDependency<CPGamesGateway>(),
        resolveDependency<CPGuardedExecutor>(),
      ),
    );

    _initialized = true;
  }

  /// Registers singleton dependency instance.
  static void registerDependency<T extends Object>(T dependency) {
    _dependencies[T] = dependency;
  }

  /// Resolves dependency by type.
  static T resolveDependency<T extends Object>() {
    final Object? dependency = _dependencies[T];
    if (dependency == null) {
      throw StateError('Dependency $T is not registered in CPDI.');
    }
    return dependency as T;
  }

  /// Resolves async dependency by type.
  static Future<T> resolveAsyncDependency<T extends Object>() async {
    return resolveDependency<T>();
  }

  /// Instance-based resolver for convenience in widgets.
  T resolve<T extends Object>() => resolveDependency<T>();
}
