import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:casino_platform_test/src/core/constants/app_constants.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Creates encrypted Hive boxes using a key persisted in secure storage.
class CPHiveSecureBoxFactory {
  /// Creates secure Hive box factory.
  const CPHiveSecureBoxFactory(this._secureStorageService);

  final CPSecureStorageService _secureStorageService;

  /// Opens encrypted box by [name].
  Future<Box<dynamic>> openEncryptedBox(String name) async {
    final List<int> key = await _loadOrGenerateKey();
    return Hive.openBox<dynamic>(
      name,
      encryptionCipher: HiveAesCipher(key),
    );
  }

  Future<List<int>> _loadOrGenerateKey() async {
    final String? encoded = await _secureStorageService
        .read(CPAppConstants.hiveCipherKeyStorageKey);
    if (encoded != null && encoded.isNotEmpty) {
      return base64Decode(encoded);
    }

    final Random random = Random.secure();
    final Uint8List bytes = Uint8List.fromList(
      List<int>.generate(32, (_) => random.nextInt(256)),
    );
    await _secureStorageService.write(
      CPAppConstants.hiveCipherKeyStorageKey,
      base64Encode(bytes),
    );
    return bytes;
  }
}
