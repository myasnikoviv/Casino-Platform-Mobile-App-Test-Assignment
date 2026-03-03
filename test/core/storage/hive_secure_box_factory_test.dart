import 'dart:io';

import 'package:casino_platform_test/src/core/storage/hive_secure_box_factory.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  group('CPHiveSecureBoxFactory', () {
    late Directory tempDir;
    late _CPFakeSecureStorageService secureStorageService;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('cp_hive_factory_test_');
      Hive.init(tempDir.path);
      secureStorageService = _CPFakeSecureStorageService();
    });

    tearDown(() async {
      await Hive.deleteFromDisk();
      await tempDir.delete(recursive: true);
    });

    test('reuses generated encryption key across box openings', () async {
      final CPHiveSecureBoxFactory factory = CPHiveSecureBoxFactory(
        secureStorageService,
      );

      final Box<dynamic> firstBox =
          await factory.openEncryptedBox('factory_test_box');
      await firstBox.put('hello', 'world');
      await firstBox.close();

      final Box<dynamic> secondBox =
          await factory.openEncryptedBox('factory_test_box');
      expect(secondBox.get('hello'), equals('world'));
      await secondBox.close();
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
