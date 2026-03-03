import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:casino_platform_test/src/core/exceptions/error_reporting_service.dart';
import 'package:casino_platform_test/src/core/exceptions/guarded_executor.dart';
import 'package:casino_platform_test/src/core/storage/hive_secure_box_factory.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/auth_local_gateway.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/auth_local_gateway_impl.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/biometric_gateway.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/biometric_gateway_impl.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service_impl.dart';
import 'package:casino_platform_test/src/core/constants/app_constants.dart';
import 'package:casino_platform_test/src/features/games/adapters/game_view_model_adapter.dart';
import 'package:casino_platform_test/src/features/games/data/dto/game_dto.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_api_gateway.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_gateway.dart';
import 'package:casino_platform_test/src/features/games/data/gateways/games_local_gateway.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:casino_platform_test/src/features/games/services/games_service_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';

/// Dependency container with explicit register/resolve APIs.
class CPDI {
  CPDI._internal();
  static final CPDI _instance = CPDI._internal();

  /// Shared singleton DI instance.
  factory CPDI() => _instance;

  final Map<Type, Object> _dependencies = <Type, Object>{};
  bool _initialized = false;

  /// Initializes all runtime dependencies.
  Future<void> init() async {
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
    registerDependency<CPBiometricGateway>(
      CPBiometricGatewayImpl(resolveDependency<CPSecureStorageService>()),
    );
    registerDependency<CPErrorReportingService>(
      const CPNoopErrorReportingService(),
    );
    registerDependency<CPGuardedExecutor>(
      CPGuardedExecutor(resolveDependency<CPErrorReportingService>()),
    );
    registerDependency<CPAuthService>(
      CPAuthServiceImpl(
        resolveDependency<CPAuthLocalGateway>(),
        resolveDependency<CPBiometricGateway>(),
        LocalAuthentication(),
        resolveDependency<CPGuardedExecutor>(),
      ),
    );
    registerDependency<CPAuthCubit>(
      CPAuthCubit(resolveDependency<CPAuthService>()),
    );

    final Box<dynamic> cacheBox =
        await Hive.openBox<dynamic>(CPAppConstants.cacheBoxName);
    registerDependency<CPGamesApiGateway>(const CPGamesApiGateway());
    registerDependency<CPGamesGateway>(const CPGamesLocalGateway());
    registerDependency<CPTtlCache<List<CPGameDto>>>(
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
    );
    registerDependency<CPGameViewModelAdapter>(const CPGameViewModelAdapter());
    registerDependency<CPGamesService>(
      CPGamesServiceImpl(
        resolveDependency<CPGamesGateway>(),
        resolveDependency<CPTtlCache<List<CPGameDto>>>(),
        resolveDependency<CPGameViewModelAdapter>(),
        resolveDependency<CPGuardedExecutor>(),
      ),
    );

    _initialized = true;
  }

  /// Registers singleton dependency instance.
  void registerDependency<T extends Object>(T dependency) {
    _dependencies[T] = dependency;
  }

  /// Resolves dependency by type.
  T resolveDependency<T extends Object>() {
    final Object? dependency = _dependencies[T];
    if (dependency == null) {
      throw StateError('Dependency $T is not registered in CPDI.');
    }
    return dependency as T;
  }

  /// Resolves async dependency by type.
  Future<T> resolveAsyncDependency<T extends Object>() async {
    return resolveDependency<T>();
  }
}
