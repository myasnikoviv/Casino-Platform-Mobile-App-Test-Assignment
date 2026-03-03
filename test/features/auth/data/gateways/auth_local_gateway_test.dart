import 'dart:io';

import 'package:casino_platform_test/src/core/storage/hive_secure_box_factory.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:casino_platform_test/src/features/auth/data/dto/local_user_dto.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/auth_local_gateway.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/auth_local_gateway_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  group('CPAuthLocalGatewayImpl', () {
    late Directory tempDir;
    late _CPFakeSecureStorageService secureStorageService;
    late CPAuthLocalGateway gateway;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('cp_auth_gateway_test_');
      Hive.init(tempDir.path);
      secureStorageService = _CPFakeSecureStorageService();
      final CPHiveSecureBoxFactory boxFactory = CPHiveSecureBoxFactory(
        secureStorageService,
      );
      gateway = CPAuthLocalGatewayImpl(boxFactory, secureStorageService);
    });

    tearDown(() async {
      await Hive.deleteFromDisk();
      await tempDir.delete(recursive: true);
    });

    test('saves and restores user by email', () async {
      const CPLocalUserDto dto = CPLocalUserDto(
        id: 'u1',
        fullName: 'Jane Doe',
        email: 'jane@example.com',
        passwordHash: 'hash',
        createdAtIso: '2026-03-03T10:00:00.000Z',
      );

      await gateway.saveUser(dto);
      final CPLocalUserDto? restored =
          await gateway.getUserByEmail('jane@example.com');

      expect(restored, isNotNull);
      expect(restored!.email, equals(dto.email));
      expect(restored.fullName, equals(dto.fullName));
    });

    test('stores and clears session email', () async {
      await gateway.saveSession('jane@example.com');
      expect(await gateway.getSessionEmail(), equals('jane@example.com'));

      await gateway.clearSession();
      expect(await gateway.getSessionEmail(), isNull);
    });
  });
}

class _CPFakeSecureStorageService implements CPSecureStorageService {
  final Map<String, String> _storage = <String, String>{};

  @override
  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  @override
  Future<String?> read(String key) async {
    return _storage[key];
  }

  @override
  Future<void> write(String key, String value) async {
    _storage[key] = value;
  }
}
